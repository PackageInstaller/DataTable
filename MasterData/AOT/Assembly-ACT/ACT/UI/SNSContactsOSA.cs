using System;
using System.Collections.Generic;
using ACT.Model;
using ACT.UI.InputController;
using Bamboo.ImageCenter;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.CustomAdapters.Tree;
using Com.ForbiddenByte.OSA.DataHelpers;
using UnityEngine;

namespace ACT.UI;

public class SNSContactsOSA : OSA<SNSContactsOSA.SNSContactsParams, SNSContactsOSA.SNSContactsBaseViewsHolder>
{
	[Serializable]
	public class SNSContactsParams : BaseParams
	{
		public RectTransform contactsPrefab;

		public RectTransform sessionPrefab;
	}

	public abstract class SNSContactsModel : ITreeNodeModel
	{
		public Type CachedType { get; }

		public ITreeNodeModel Parent { get; set; }

		public List<ITreeNodeModel> Children { get; set; }

		public int Depth { get; set; }

		public bool Expanded { get; set; }

		public bool Finish { get; set; }

		protected SNSContactsModel()
		{
			CachedType = GetType();
			Children = new List<ITreeNodeModel>();
		}
	}

	public class ContactsCharacterModel : SNSContactsModel
	{
		public int ContactsId { get; }

		public ContactsCharacterModel(int contactsId)
		{
			ContactsId = contactsId;
		}
	}

	public class ContactsSessionModel : SNSContactsModel
	{
		public bool Selected;

		public int SessionId { get; }

		public ContactsSessionModel(int sessionId)
		{
			SessionId = sessionId;
			Selected = false;
		}
	}

	public abstract class SNSContactsBaseViewsHolder : BaseItemViewsHolder, ITreeNodeViewsHolder
	{
		protected ImageAssetStation _imageAssetStation;

		public void SetImageAssetStation(ImageAssetStation imageAssetStation)
		{
			_imageAssetStation = imageAssetStation;
		}

		public virtual void UpdateViews(ITreeNodeModel model)
		{
			root.gameObject.SetActive(value: true);
		}

		public virtual void SetOnToggleFoldoutListener(Action<ITreeNodeViewsHolder> onFoldOutToggled)
		{
		}

		public virtual void SetRedDot(SNSContactsModel model)
		{
		}

		public virtual void PlayClickAnimation(ITreeNodeModel model, bool selected)
		{
		}

		public virtual void PlayInitAnimation(ITreeNodeModel model, bool selected)
		{
		}

		public virtual void PlayUnInitAnimation()
		{
		}

		public abstract bool CanPresentModelType(Type modelType);
	}

	private class ContactsCharacterVh : SNSContactsBaseViewsHolder
	{
		public ContactsComp _contactsComp;

		public override void CollectViews()
		{
			base.CollectViews();
			_contactsComp = root.GetComponent<ContactsComp>();
		}

		public override void UpdateViews(ITreeNodeModel model)
		{
			base.UpdateViews(model);
			ContactsCharacterModel contactsCharacterModel = model as ContactsCharacterModel;
			SNSModel.SnsContacts contacts = Model<SNSModel>.Interface.GetContacts(contactsCharacterModel.ContactsId);
			_contactsComp.Init(contacts.Id, _imageAssetStation, contacts.Icon, contacts.Name, model.Expanded);
		}

		public override void SetOnToggleFoldoutListener(Action<ITreeNodeViewsHolder> onFoldOutToggled)
		{
			_contactsComp.Btn.OnClick.RemoveAllListeners();
			_contactsComp.Btn.OnClick.AddListener(() =>
			{
				onFoldOutToggled(this);
			});
		}

		public override void SetRedDot(SNSContactsModel model)
		{
			_contactsComp.SetRedDot();
		}

		public override void PlayClickAnimation(ITreeNodeModel model, bool selected)
		{
			if (!(_contactsComp == null))
			{
				_contactsComp.PlayAnimation(model.Expanded);
			}
		}

		public override void PlayInitAnimation(ITreeNodeModel model, bool selected)
		{
			if (!(_contactsComp == null))
			{
				_contactsComp.PlayInitAnimation(model.Expanded);
			}
		}

		public override void PlayUnInitAnimation()
		{
			if (!(_contactsComp == null))
			{
				_contactsComp.PlayUnInitAnimation();
			}
		}

		public override bool CanPresentModelType(Type modelType)
		{
			return modelType == typeof(ContactsCharacterModel);
		}
	}

	private class ContactsSessionVh : SNSContactsBaseViewsHolder
	{
		public SessionComp _sessionComp;

		public override void CollectViews()
		{
			base.CollectViews();
			_sessionComp = root.GetComponent<SessionComp>();
		}

		public override void UpdateViews(ITreeNodeModel model)
		{
			base.UpdateViews(model);
			ContactsSessionModel contactsSessionModel = model as ContactsSessionModel;
			SNSModel.SnsSession session = Model<SNSModel>.Interface.GetSession(contactsSessionModel.SessionId);
			_sessionComp.UnInit();
			_sessionComp.Init(session.Id, contactsSessionModel.Selected, _imageAssetStation);
		}

		public override void OnBeforeDestroy()
		{
			base.OnBeforeDestroy();
			_sessionComp.UnInit();
		}

		public void SetOnSessionSelectListener(Action<ITreeNodeViewsHolder> selectSession)
		{
			_sessionComp.Btn.OnClick.RemoveAllListeners();
			_sessionComp.Btn.OnClick.AddListener(() =>
			{
				selectSession(this);
			});
		}

		public override void SetRedDot(SNSContactsModel model)
		{
			_sessionComp.SetRedDot();
		}

		public override void PlayClickAnimation(ITreeNodeModel model, bool selected)
		{
			_sessionComp.PlayAnimation(selected);
		}

		public override void PlayInitAnimation(ITreeNodeModel model, bool selected)
		{
			_sessionComp.PlayInitAnimation(selected);
		}

		public override void PlayUnInitAnimation()
		{
			_sessionComp.PlayUnInitAnimation();
		}

		public override bool CanPresentModelType(Type modelType)
		{
			return modelType == typeof(ContactsSessionModel);
		}
	}

	private TreeDataHelper<SNSContactsModel> _data;

	private ImageAssetStation _imageAssetStation;

	private Action<int> _selectSession;

	private ContactsCharacterVh _currentExpandedVh;

	private ContactsCharacterModel _currentExpandedModel;

	private ContactsSessionVh _currentSelectedSessionVh;

	private ContactsSessionModel _currentSelectedSessionModel;

	public GameObject CurrentExpandedVhGo => _currentExpandedVh.root.gameObject;

	public TreeDataHelper<SNSContactsModel> Data => _data;

	protected override void Start()
	{
	}

	public void Reload(ImageAssetStation imageAssetStation, Action<int> selectSession)
	{
		Model<SNSModel>.Interface.UpdateRedTreeBySessionFinish();
		int num = 0;
		int sessionIndex = 0;
		SNSModel.SpecificMsg specificMsg = Model<SNSModel>.Interface.UseSpecificMsg();
		_imageAssetStation = imageAssetStation;
		_selectSession = selectSession;
		_data = new TreeDataHelper<SNSContactsModel>(this);
		List<SNSModel.SnsContacts> allContacts = Model<SNSModel>.Interface.GetAllContacts(needReset: true, needSort: true);
		for (int i = 0; i < allContacts.Count; i++)
		{
			bool flag = false;
			SNSModel.SnsContacts snsContacts = allContacts[i];
			ContactsCharacterModel contactsCharacterModel = new ContactsCharacterModel(snsContacts.Id);
			if (snsContacts.Id == specificMsg.ContactId)
			{
				flag = true;
				num = i;
			}
			_data.AddTreeNode(null, contactsCharacterModel, Model<SNSModel>.Interface.GetContactsIndex(snsContacts.Id));
			for (int j = 0; j < snsContacts._OrderedSessionId.Count; j++)
			{
				if (flag && snsContacts._OrderedSessionId[j] == specificMsg.SessionId)
				{
					sessionIndex = j;
				}
				_data.AddTreeNode(contactsCharacterModel, new ContactsSessionModel(snsContacts._OrderedSessionId[j]), j);
			}
		}
		if (!IsInitialized)
		{
			Init();
		}
		_data.ResetItems();
		if (GetItemViewsHolderIfVisible(num) is ContactsCharacterVh vh)
		{
			InitContactsAnimation(vh, sessionIndex);
			return;
		}
		ScrollTo(num, 0.5f, 0.5f);
		if (GetItemViewsHolderIfVisible(num) is ContactsCharacterVh vh2)
		{
			InitContactsAnimation(vh2, sessionIndex);
		}
	}

	public void UpdateView(int focusSessionId, bool needReset)
	{
		int withItemIndex = 0;
		int sessionIndex = 0;
		_data = new TreeDataHelper<SNSContactsModel>(this);
		List<SNSModel.SnsContacts> allContacts = Model<SNSModel>.Interface.GetAllContacts(needReset);
		for (int i = 0; i < allContacts.Count; i++)
		{
			SNSModel.SnsContacts snsContacts = allContacts[i];
			ContactsCharacterModel contactsCharacterModel = new ContactsCharacterModel(snsContacts.Id);
			if (snsContacts._OrderedSessionId.Contains(focusSessionId))
			{
				withItemIndex = i;
			}
			_data.AddTreeNode(null, contactsCharacterModel, Model<SNSModel>.Interface.GetContactsIndex(snsContacts.Id));
			for (int j = 0; j < snsContacts._OrderedSessionId.Count; j++)
			{
				if (snsContacts._OrderedSessionId[j] == focusSessionId)
				{
					sessionIndex = j;
				}
				_data.AddTreeNode(contactsCharacterModel, new ContactsSessionModel(snsContacts._OrderedSessionId[j]), j);
			}
		}
		if (!IsInitialized)
		{
			Init();
		}
		_data.ResetItems();
		_currentExpandedVh = GetItemViewsHolderIfVisible(withItemIndex) as ContactsCharacterVh;
		UpdateContactsAnimation(_currentExpandedVh, sessionIndex);
	}

	public void UnInit()
	{
		for (int i = 0; i < _data.ShowCount; i++)
		{
			if (_data[i] is ContactsCharacterModel)
			{
				(GetItemViewsHolderIfVisible(i) as ContactsCharacterVh)?.PlayUnInitAnimation();
			}
			if (_data[i] is ContactsSessionModel)
			{
				(GetItemViewsHolderIfVisible(i) as ContactsSessionVh)?.PlayUnInitAnimation();
			}
		}
	}

	protected override SNSContactsBaseViewsHolder CreateViewsHolder(int itemIndex)
	{
		Type cachedType = _data[itemIndex].CachedType;
		if (cachedType == typeof(ContactsCharacterModel))
		{
			ContactsCharacterVh contactsCharacterVh = new ContactsCharacterVh();
			contactsCharacterVh.Init(_Params.contactsPrefab, _Params.Content, itemIndex);
			contactsCharacterVh.SetImageAssetStation(_imageAssetStation);
			contactsCharacterVh.SetOnToggleFoldoutListener(OnContactsClicked);
			return contactsCharacterVh;
		}
		if (cachedType == typeof(ContactsSessionModel))
		{
			ContactsSessionVh contactsSessionVh = new ContactsSessionVh();
			contactsSessionVh.Init(_Params.sessionPrefab, _Params.Content, itemIndex);
			contactsSessionVh.SetImageAssetStation(_imageAssetStation);
			contactsSessionVh.SetOnSessionSelectListener(OnSessionSelect);
			return contactsSessionVh;
		}
		throw new InvalidOperationException("Unrecognized model type: " + cachedType.Name);
	}

	protected override void UpdateViewsHolder(SNSContactsBaseViewsHolder newOrRecycled)
	{
		SNSContactsModel model = _data[newOrRecycled.ItemIndex] as SNSContactsModel;
		newOrRecycled.UpdateViews(model);
		ScheduleComputeVisibilityTwinPass();
	}

	protected override bool IsRecyclable(SNSContactsBaseViewsHolder potentiallyRecyclable, int indexOfItemThatWillBecomeVisible, double sizeOfItemThatWillBecomeVisible)
	{
		ITreeNodeModel treeNodeModel = _data[indexOfItemThatWillBecomeVisible];
		if (potentiallyRecyclable.ItemIndex > _data.ShowCount - 1)
		{
			return false;
		}
		if (potentiallyRecyclable.CanPresentModelType(treeNodeModel.CachedType))
		{
			return treeNodeModel.Expanded == _data[potentiallyRecyclable.ItemIndex].Expanded;
		}
		return false;
	}

	protected override void CollectItemsSizes(ItemCountChangeMode changeMode, int count, int indexIfInsertingOrRemoving, ItemsDescriptor itemsDesc)
	{
		base.CollectItemsSizes(changeMode, count, indexIfInsertingOrRemoving, itemsDesc);
		for (int i = 0; i < _data.ShowCount; i++)
		{
			if (_data[i] is ContactsSessionModel)
			{
				itemsDesc.BeginChangingItemsSizes(i);
				itemsDesc[i] = _Params.sessionPrefab.rect.height;
				itemsDesc.EndChangingItemsSizes();
			}
		}
	}

	private void InitContactsAnimation(ITreeNodeViewsHolder vh, int sessionIndex)
	{
		if (!(vh is ContactsCharacterVh currentExpandedVh) || !(_data[vh.ItemIndex] is ContactsCharacterModel contactsCharacterModel))
		{
			return;
		}
		_currentExpandedVh = currentExpandedVh;
		_currentExpandedModel = contactsCharacterModel;
		_currentExpandedVh._contactsComp.Select.SetActive(value: true);
		_data.Expand(contactsCharacterModel);
		for (int i = 0; i < _data.ShowCount; i++)
		{
			if (_data[i] is ContactsCharacterModel model)
			{
				(GetItemViewsHolderIfVisible(i) as ContactsCharacterVh)?.PlayInitAnimation(model, _data[i].Expanded);
			}
		}
		InitSessionSelect(GetItemViewsHolderIfVisible(vh.ItemIndex + 1 + sessionIndex) as ContactsSessionVh);
	}

	private void UpdateContactsAnimation(ITreeNodeViewsHolder vh, int sessionIndex)
	{
		if (vh == null || !(_data[vh.ItemIndex] is ContactsCharacterModel contactsCharacterModel) || !(vh is ContactsCharacterVh currentExpandedVh))
		{
			return;
		}
		if (_currentExpandedVh != null && _currentExpandedModel != null && _currentExpandedModel.Expanded)
		{
			ContactsCharacterVh currentExpandedVh2 = _currentExpandedVh;
			ContactsCharacterModel currentExpandedModel = _currentExpandedModel;
			_data.Collapse(currentExpandedModel);
			currentExpandedVh2.PlayClickAnimation(currentExpandedModel, selected: false);
		}
		_currentExpandedVh = currentExpandedVh;
		_currentExpandedModel = contactsCharacterModel;
		_data.Expand(contactsCharacterModel);
		for (int i = 0; i < _data.ShowCount; i++)
		{
			if (_data[i] is ContactsCharacterModel model)
			{
				(GetItemViewsHolderIfVisible(i) as ContactsCharacterVh)?.PlayClickAnimation(model, _data[i].Expanded);
			}
		}
		UpdateSessionSelect(GetItemViewsHolderIfVisible(vh.ItemIndex + 1 + sessionIndex) as ContactsSessionVh);
	}

	private void OnContactsClicked(ITreeNodeViewsHolder vh)
	{
		if (!Model<SNSModel>.Interface.FocusMessageLock && _data[vh.ItemIndex] is ContactsCharacterModel contactsCharacterModel && vh is ContactsCharacterVh contactsCharacterVh && (_currentExpandedModel != contactsCharacterModel || !contactsCharacterModel.Expanded))
		{
			if (_currentExpandedVh != null && _currentExpandedModel != null && _currentExpandedModel.Expanded)
			{
				ContactsCharacterVh currentExpandedVh = _currentExpandedVh;
				ContactsCharacterModel currentExpandedModel = _currentExpandedModel;
				_data.Collapse(currentExpandedModel);
				currentExpandedVh.PlayClickAnimation(currentExpandedModel, selected: false);
			}
			_currentExpandedVh = contactsCharacterVh;
			_currentExpandedModel = contactsCharacterModel;
			_data.Expand(contactsCharacterModel);
			ForceRebuildLayoutNow();
			contactsCharacterVh.PlayClickAnimation(contactsCharacterModel, selected: true);
			InitSessionSelect(GetItemViewsHolderIfVisible(vh.ItemIndex + 1) as ContactsSessionVh);
		}
	}

	private void InitSessionSelect(ITreeNodeViewsHolder vh)
	{
		if (vh == null || !(_data[vh.ItemIndex] is ContactsSessionModel contactsSessionModel))
		{
			return;
		}
		ContactsSessionVh contactsSessionVh = (_currentSelectedSessionVh = vh as ContactsSessionVh);
		_currentSelectedSessionModel = contactsSessionModel;
		EventSystemHelper.SetSelectedGameObject(contactsSessionVh?._sessionComp.gameObject);
		for (int i = 0; i < _data.ShowCount; i++)
		{
			if (_data[i] is ContactsSessionModel contactsSessionModel2)
			{
				contactsSessionModel2.Selected = _currentSelectedSessionModel == contactsSessionModel2;
				(GetItemViewsHolderIfVisible(i) as ContactsSessionVh)?.PlayInitAnimation(contactsSessionModel2, contactsSessionModel2.Selected);
			}
		}
		_selectSession(contactsSessionModel.SessionId);
	}

	private void UpdateSessionSelect(ITreeNodeViewsHolder vh)
	{
		if (!(_data[vh.ItemIndex] is ContactsSessionModel currentSelectedSessionModel))
		{
			return;
		}
		ContactsSessionVh contactsSessionVh = (_currentSelectedSessionVh = vh as ContactsSessionVh);
		_currentSelectedSessionModel = currentSelectedSessionModel;
		EventSystemHelper.SetSelectedGameObject(contactsSessionVh?._sessionComp.gameObject);
		for (int i = 0; i < _data.ShowCount; i++)
		{
			if (_data[i] is ContactsSessionModel contactsSessionModel)
			{
				contactsSessionModel.Selected = _currentSelectedSessionModel == contactsSessionModel;
				(GetItemViewsHolderIfVisible(i) as ContactsSessionVh)?.PlayInitAnimation(contactsSessionModel, contactsSessionModel.Selected);
			}
		}
	}

	private void OnSessionSelect(ITreeNodeViewsHolder vh)
	{
		if (!Model<SNSModel>.Interface.FocusMessageLock && _data[vh.ItemIndex] is ContactsSessionModel contactsSessionModel && vh is ContactsSessionVh currentSelectedSessionVh && _currentSelectedSessionModel != contactsSessionModel)
		{
			if (_currentSelectedSessionVh != null)
			{
				_currentSelectedSessionModel.Selected = false;
				_currentSelectedSessionVh.PlayClickAnimation(_currentSelectedSessionModel, selected: false);
			}
			_currentSelectedSessionVh = currentSelectedSessionVh;
			_currentSelectedSessionModel = contactsSessionModel;
			_currentSelectedSessionModel.Selected = true;
			_currentSelectedSessionVh.PlayClickAnimation(_currentSelectedSessionModel, selected: true);
			EventSystemHelper.SetSelectedGameObject(_currentSelectedSessionVh?._sessionComp.gameObject);
			_selectSession(contactsSessionModel.SessionId);
		}
	}

	public void OnSessionFinish(int sessionId)
	{
		ContactsSessionModel contactsSessionModel = _data.GetNode((SNSContactsModel node) => node is ContactsSessionModel contactsSessionModel2 && contactsSessionModel2.SessionId == sessionId) as ContactsSessionModel;
		contactsSessionModel.Finish = true;
		int indexInVisible = _data.GetIndexInVisible(contactsSessionModel);
		if (indexInVisible != -1)
		{
			GetItemViewsHolderIfVisible(indexInVisible)?.SetRedDot(contactsSessionModel);
		}
		ContactsCharacterModel contactsCharacterModel = contactsSessionModel.Parent as ContactsCharacterModel;
		contactsCharacterModel.Finish = true;
		int indexInVisible2 = _data.GetIndexInVisible(contactsCharacterModel);
		if (indexInVisible2 != -1)
		{
			GetItemViewsHolderIfVisible(indexInVisible2)?.SetRedDot(contactsCharacterModel);
		}
	}
}
