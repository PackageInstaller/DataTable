using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.DataHelpers;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SNSSessionOSA : OSA<SNSSessionOSA.SNSSessionParams, SNSSessionOSA.SNSSessionMessageVh>
{
	[Serializable]
	public class SNSSessionParams : BaseParams
	{
		public RectTransform otherMessagePrefab;

		public RectTransform selfMessagePrefab;

		public RectTransform systemPromptPrefab;

		public RectTransform missionPrefab;

		public RectTransform rewardPrefab;

		public RectTransform emptyPrefab;

		public RectTransform endPrefab;
	}

	public abstract class SNSSessionMessageModel
	{
		public long MessageId { get; set; }

		public SNSModel.MessageType Type { get; }

		public bool OnRight { get; }

		public bool HasPendingVisualSizeChange { get; set; }

		protected SNSSessionMessageModel(MessageConversation messageConversation, bool onRight)
		{
			MessageId = messageConversation?.id ?? 0;
			OnRight = onRight;
			HasPendingVisualSizeChange = true;
		}
	}

	public class TextMessageModel : SNSSessionMessageModel
	{
		public int SpeakerId { get; }

		public new long MessageId { get; }

		public int SessionId { get; }

		public bool Appear { get; set; }

		public int Delaytime { get; set; }

		public TextMessageModel(MessageConversation messageConversation, bool onRight, long messageId, int sessionId, bool appear)
			: base(messageConversation, onRight)
		{
			SpeakerId = messageConversation.speaker;
			MessageId = messageId;
			SessionId = sessionId;
			Appear = appear;
		}
	}

	public class ImageMessageModel : SNSSessionMessageModel
	{
		public int SpeakerId { get; }

		public int SessionId { get; }

		public bool Appear { get; set; }

		public GroupImageData ImageData { get; }

		public ImageMessageModel(MessageConversation messageConversation, bool onRight, int sessionId, bool appear)
			: base(messageConversation, onRight)
		{
			SpeakerId = messageConversation.speaker;
			SessionId = sessionId;
			Appear = appear;
			ImageData = new GroupImageData(ItemIconAtlasNameMap.GetConfigId(messageConversation.conversationParm[0]), messageConversation.conversationParm[0]);
		}
	}

	public class FileMessageModel : SNSSessionMessageModel
	{
		public int SpeakerId { get; }

		public int SessionId { get; }

		public new long MessageId { get; }

		public bool Appear { get; set; }

		public FileMessageModel(MessageConversation messageConversation, bool onRight, long messageId, int sessionId, bool appear)
			: base(messageConversation, onRight)
		{
			SpeakerId = messageConversation.speaker;
			MessageId = messageId;
			SessionId = sessionId;
			Appear = appear;
		}
	}

	public class SystemPromptMessageModel : SNSSessionMessageModel
	{
		public LocalizeStringData Content { get; }

		public int SessionId { get; }

		public bool Appear { get; set; }

		public SystemPromptMessageModel(MessageConversation messageConversation, bool onRight, int sessionId, bool appear)
			: base(messageConversation, onRight)
		{
			SessionId = sessionId;
			Appear = appear;
			Content = new LocalizeStringData(LocalizeTable.MainStory, messageConversation.content);
		}
	}

	public class MissionMessageModel : SNSSessionMessageModel
	{
		public int SpeakerId { get; }

		public int MissionId { get; }

		public new long MessageId { get; }

		public int SessionId { get; }

		public bool Appear { get; set; }

		public MissionMessageModel(MessageConversation messageConversation, bool onRight, int sessionId, bool appear)
			: base(messageConversation, onRight)
		{
			SpeakerId = messageConversation.speaker;
			MessageId = messageConversation.id;
			SessionId = sessionId;
			Appear = appear;
			MissionId = messageConversation.conversationParm[0];
		}
	}

	public class RewardMessageModel : SNSSessionMessageModel
	{
		public int SpeakerId { get; }

		public new long MessageId { get; }

		public int SessionId { get; }

		public int RewardId { get; }

		public int RewardCount { get; }

		public bool Appear { get; set; }

		public RewardMessageModel(MessageConversation messageConversation, bool onRight, int rewardId, int rewardCount, int sessionId, bool appear)
			: base(messageConversation, onRight)
		{
			SpeakerId = messageConversation.speaker;
			MessageId = messageConversation.id;
			SessionId = sessionId;
			RewardId = rewardId;
			RewardCount = rewardCount;
			Appear = appear;
		}
	}

	public class EmptyModel : SNSSessionMessageModel
	{
		public EmptyModel(MessageConversation messageConversation, bool onRight)
			: base(messageConversation, onRight)
		{
		}
	}

	public class EndModel : SNSSessionMessageModel
	{
		public int SessionId { get; }

		public bool Appear { get; set; }

		public EndModel(MessageConversation messageConversation, bool onRight, int sessionId, bool appear)
			: base(messageConversation, onRight)
		{
			SessionId = sessionId;
			Appear = appear;
		}
	}

	public abstract class SNSSessionMessageVh : BaseItemViewsHolder
	{
		internal ContentSizeFitter ContentSizeFitter { get; private set; }

		protected ImageAssetStation ImageAssetStation { get; set; }

		public abstract bool MathModel(SNSSessionMessageModel model);

		public override void CollectViews()
		{
			base.CollectViews();
			ContentSizeFitter = root.GetComponent<ContentSizeFitter>();
			if ((bool)ContentSizeFitter)
			{
				ContentSizeFitter.enabled = false;
			}
		}

		public void SetImageAssetStation(ImageAssetStation imageAssetStation)
		{
			ImageAssetStation = imageAssetStation;
		}

		public virtual void UpdateFormModel(SNSSessionMessageModel model)
		{
			root.gameObject.SetActive(value: true);
		}

		public override void MarkForRebuild()
		{
			base.MarkForRebuild();
			if ((bool)ContentSizeFitter)
			{
				ContentSizeFitter.enabled = true;
			}
		}

		public override void UnmarkForRebuild()
		{
			if ((bool)ContentSizeFitter)
			{
				ContentSizeFitter.enabled = false;
			}
			base.UnmarkForRebuild();
		}
	}

	public class OtherMessageVh : SNSSessionMessageVh
	{
		private OtherMessageComp _otherMessageComp;

		public override bool MathModel(SNSSessionMessageModel model)
		{
			if (model is TextMessageModel || model is ImageMessageModel || model is FileMessageModel)
			{
				return !model.OnRight;
			}
			return false;
		}

		public override void CollectViews()
		{
			base.CollectViews();
			_otherMessageComp = root.GetComponent<OtherMessageComp>();
		}

		public override void UpdateFormModel(SNSSessionMessageModel model)
		{
			base.UpdateFormModel(model);
			if (model is TextMessageModel textMessageModel)
			{
				_otherMessageComp.Init(textMessageModel.SessionId, textMessageModel.SpeakerId, textMessageModel.MessageId, ImageAssetStation, textMessageModel.Appear, ContentSizeFitter, root);
				textMessageModel.Appear = true;
			}
			else if (model is ImageMessageModel imageMessageModel)
			{
				ContentSizeFitter.enabled = true;
				_otherMessageComp.ImageInit(imageMessageModel.SessionId, imageMessageModel.SpeakerId, imageMessageModel.MessageId, ImageAssetStation, imageMessageModel.Appear);
				imageMessageModel.Appear = true;
				MarkForRebuild();
				model.HasPendingVisualSizeChange = true;
			}
			else if (model is FileMessageModel fileMessageModel)
			{
				ContentSizeFitter.enabled = true;
				_otherMessageComp.ZipInit(fileMessageModel.SessionId, fileMessageModel.SpeakerId, fileMessageModel.MessageId, ImageAssetStation, fileMessageModel.Appear);
				fileMessageModel.Appear = true;
				MarkForRebuild();
				model.HasPendingVisualSizeChange = true;
			}
		}
	}

	public class SelfMessageVh : SNSSessionMessageVh
	{
		private SelfMessageComp _selfMessageComp;

		public override bool MathModel(SNSSessionMessageModel model)
		{
			if (model is TextMessageModel || model is ImageMessageModel || model is FileMessageModel)
			{
				return model.OnRight;
			}
			return false;
		}

		public override void CollectViews()
		{
			base.CollectViews();
			_selfMessageComp = root.GetComponent<SelfMessageComp>();
		}

		public override void UpdateFormModel(SNSSessionMessageModel model)
		{
			base.UpdateFormModel(model);
			if (model is TextMessageModel textMessageModel)
			{
				_selfMessageComp.Init(textMessageModel.SessionId, textMessageModel.SpeakerId, textMessageModel.MessageId, ImageAssetStation, textMessageModel.Appear);
				textMessageModel.Appear = true;
			}
			else if (model is ImageMessageModel imageMessageModel)
			{
				_selfMessageComp.ImageInit(imageMessageModel.SessionId, imageMessageModel.SpeakerId, imageMessageModel.MessageId, ImageAssetStation, imageMessageModel.Appear);
				imageMessageModel.Appear = true;
				MarkForRebuild();
				model.HasPendingVisualSizeChange = true;
			}
			else if (model is FileMessageModel fileMessageModel)
			{
				_selfMessageComp.ZipInit(fileMessageModel.SessionId, fileMessageModel.SpeakerId, fileMessageModel.MessageId, ImageAssetStation, fileMessageModel.Appear);
				fileMessageModel.Appear = true;
				MarkForRebuild();
				model.HasPendingVisualSizeChange = true;
			}
		}
	}

	private class SystemPromptVh : SNSSessionMessageVh
	{
		private SystemPromptComp _systemPromptComp;

		public override bool MathModel(SNSSessionMessageModel model)
		{
			return model is SystemPromptMessageModel;
		}

		public override void CollectViews()
		{
			base.CollectViews();
			_systemPromptComp = root.GetComponent<SystemPromptComp>();
		}

		public override void MarkForRebuild()
		{
			base.MarkForRebuild();
		}

		public override void UpdateFormModel(SNSSessionMessageModel model)
		{
			base.UpdateFormModel(model);
			if (model is SystemPromptMessageModel systemPromptMessageModel)
			{
				_systemPromptComp.Init(systemPromptMessageModel.MessageId, systemPromptMessageModel.SessionId, systemPromptMessageModel.Appear, ImageAssetStation);
				systemPromptMessageModel.Appear = true;
			}
		}
	}

	private class MissionVh : SNSSessionMessageVh
	{
		private MissionMessageComp _missionMessageComp;

		public override bool MathModel(SNSSessionMessageModel model)
		{
			return model is MissionMessageModel;
		}

		public override void CollectViews()
		{
			base.CollectViews();
			_missionMessageComp = root.GetComponent<MissionMessageComp>();
		}

		public override void UpdateFormModel(SNSSessionMessageModel model)
		{
			base.UpdateFormModel(model);
			if (model is MissionMessageModel missionMessageModel)
			{
				_missionMessageComp.Init(missionMessageModel.SessionId, missionMessageModel.MessageId, missionMessageModel.MissionId, ImageAssetStation, missionMessageModel.Appear);
				missionMessageModel.Appear = true;
			}
		}

		public void SetBtnListener(Action method)
		{
			_missionMessageComp.Btn.OnClick.RemoveAllListeners();
			_missionMessageComp.Btn.OnClick.AddListener(() =>
			{
				method();
			});
		}
	}

	private class RewardVh : SNSSessionMessageVh
	{
		private RewardMessageComp _rewardMessageComp;

		public override bool MathModel(SNSSessionMessageModel model)
		{
			return model is RewardMessageModel;
		}

		public override void CollectViews()
		{
			base.CollectViews();
			_rewardMessageComp = root.GetComponent<RewardMessageComp>();
		}

		public override void UpdateFormModel(SNSSessionMessageModel model)
		{
			base.UpdateFormModel(model);
			if (model is RewardMessageModel rewardMessageModel)
			{
				_rewardMessageComp.Init(rewardMessageModel.SessionId, rewardMessageModel.MessageId, rewardMessageModel.SpeakerId, rewardMessageModel.RewardId, rewardMessageModel.RewardCount, ImageAssetStation, rewardMessageModel.Appear);
				rewardMessageModel.Appear = true;
			}
		}
	}

	private class EmptyVh : SNSSessionMessageVh
	{
		public override bool MathModel(SNSSessionMessageModel model)
		{
			return model is EmptyModel;
		}
	}

	private class EndVh : SNSSessionMessageVh
	{
		private MessageEndComp _messageEndComp;

		public override bool MathModel(SNSSessionMessageModel model)
		{
			return model is EndModel;
		}

		public override void CollectViews()
		{
			base.CollectViews();
			_messageEndComp = root.GetComponent<MessageEndComp>();
		}

		public override void UpdateFormModel(SNSSessionMessageModel model)
		{
			base.UpdateFormModel(model);
			if (model is EndModel endModel)
			{
				_messageEndComp.Init(endModel.MessageId, endModel.SessionId, endModel.Appear);
				endModel.Appear = true;
			}
		}
	}

	public SimpleDataHelper<SNSSessionMessageModel> data;

	private int _sessionId;

	private ImageAssetStation _imageAssetStation;

	private const int DefaultDelay = 50;

	protected override void Start()
	{
	}

	public void Reload(SNSModel.SnsSession session, ImageAssetStation imageAssetStation)
	{
		_sessionId = session.Id;
		_imageAssetStation = imageAssetStation;
		data = new SimpleDataHelper<SNSSessionMessageModel>(this);
		List<SNSSessionMessageModel> list = new List<SNSSessionMessageModel>();
		List<(int, long)> list2 = (Model<SNSModel>.Interface.IsInteractionSession(session.Id) ? Model<SNSModel>.Interface.GetInteractionDisplayMessages(session.ContactsId) : null);
		if (list2 != null)
		{
			foreach (var item3 in list2)
			{
				int item = item3.Item1;
				long item2 = item3.Item2;
				SNSSessionMessageModel sNSSessionMessageModel = CreateModel(item2, item, appear: true);
				if (sNSSessionMessageModel != null)
				{
					list.Add(sNSSessionMessageModel);
				}
			}
		}
		else
		{
			for (int i = 0; i < session.messages.Count; i++)
			{
				SNSSessionMessageModel sNSSessionMessageModel2 = CreateModel(session.messages[i], session.Id, appear: true);
				if (sNSSessionMessageModel2 != null)
				{
					list.Add(sNSSessionMessageModel2);
				}
			}
		}
		if (!IsInitialized)
		{
			Init();
		}
		data.ResetItems(list, freezeEndEdge: true);
		if (data.Count > 0)
		{
			ForceRebuildLayoutNow();
			ScrollToBottom();
		}
	}

	protected override void OnDestroy()
	{
		if (_Params.Scrollbar != null)
		{
			_Params.Scrollbar.onValueChanged.RemoveAllListeners();
		}
	}

	private void OnScrollbarValueChanged(float value)
	{
		SetNormalizedPosition(1f - value);
	}

	private SNSSessionMessageModel CreateModel(long messageId, int sessionId, bool appear)
	{
		if (messageId == 0L && sessionId != 0)
		{
			return new EndModel(null, onRight: false, sessionId, appear);
		}
		MessageConversation messageConversation = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations);
		MessageCharacterData messageCharacterData = ((messageConversation.speaker != 0) ? CoreUtils.GetData(messageConversation.speaker, RuntimeConfigs.data.messageCharacterDatas) : null);
		if (messageConversation.conversationType == 1)
		{
			return new TextMessageModel(messageConversation, messageCharacterData?.inRight ?? false, messageId, sessionId, appear);
		}
		if (messageConversation.conversationType == 2)
		{
			return new ImageMessageModel(messageConversation, messageCharacterData?.inRight ?? false, sessionId, appear);
		}
		if (messageConversation.conversationType == 7)
		{
			return new FileMessageModel(messageConversation, messageCharacterData?.inRight ?? false, messageId, sessionId, appear);
		}
		if (messageConversation.conversationType == 3)
		{
			return new SystemPromptMessageModel(messageConversation, onRight: false, sessionId, appear);
		}
		if (messageConversation.conversationType == 4)
		{
			return new MissionMessageModel(messageConversation, onRight: false, sessionId, appear);
		}
		if (messageConversation.conversationType == 6)
		{
			List<Item> list = new List<Item>();
			foreach (ItemKv item2 in RuntimeConfigs.data.collections[messageConversation.conversationParm[0]].certain)
			{
				Item item = new Item
				{
					Id = item2.id,
					Count = item2.count
				};
				list.Add(item);
			}
			if (list.Count <= 0)
			{
				return null;
			}
			return new RewardMessageModel(messageConversation, messageCharacterData?.inRight ?? false, list[0].Id, list[0].Count, sessionId, appear);
		}
		if (messageConversation.conversationType == 5)
		{
			return new EmptyModel(messageConversation, onRight: false);
		}
		return null;
	}

	protected override SNSSessionMessageVh CreateViewsHolder(int itemIndex)
	{
		SNSSessionMessageModel sNSSessionMessageModel = data[itemIndex];
		if (sNSSessionMessageModel is TextMessageModel textMessageModel)
		{
			if (textMessageModel.OnRight)
			{
				SelfMessageVh selfMessageVh = new SelfMessageVh();
				selfMessageVh.Init(_Params.selfMessagePrefab, _Params.Content, itemIndex);
				selfMessageVh.SetImageAssetStation(_imageAssetStation);
				return selfMessageVh;
			}
			OtherMessageVh otherMessageVh = new OtherMessageVh();
			otherMessageVh.Init(_Params.otherMessagePrefab, _Params.Content, itemIndex);
			otherMessageVh.SetImageAssetStation(_imageAssetStation);
			return otherMessageVh;
		}
		if (sNSSessionMessageModel is ImageMessageModel imageMessageModel)
		{
			if (imageMessageModel.OnRight)
			{
				SelfMessageVh selfMessageVh2 = new SelfMessageVh();
				selfMessageVh2.Init(_Params.selfMessagePrefab, _Params.Content, itemIndex);
				selfMessageVh2.SetImageAssetStation(_imageAssetStation);
				imageMessageModel.HasPendingVisualSizeChange = true;
				return selfMessageVh2;
			}
			OtherMessageVh otherMessageVh2 = new OtherMessageVh();
			otherMessageVh2.Init(_Params.otherMessagePrefab, _Params.Content, itemIndex);
			otherMessageVh2.SetImageAssetStation(_imageAssetStation);
			return otherMessageVh2;
		}
		if (sNSSessionMessageModel is FileMessageModel fileMessageModel)
		{
			if (fileMessageModel.OnRight)
			{
				SelfMessageVh selfMessageVh3 = new SelfMessageVh();
				selfMessageVh3.Init(_Params.selfMessagePrefab, _Params.Content, itemIndex);
				selfMessageVh3.SetImageAssetStation(_imageAssetStation);
				return selfMessageVh3;
			}
			OtherMessageVh otherMessageVh3 = new OtherMessageVh();
			otherMessageVh3.Init(_Params.otherMessagePrefab, _Params.Content, itemIndex);
			otherMessageVh3.SetImageAssetStation(_imageAssetStation);
			return otherMessageVh3;
		}
		if (sNSSessionMessageModel is SystemPromptMessageModel)
		{
			SystemPromptVh systemPromptVh = new SystemPromptVh();
			systemPromptVh.Init(_Params.systemPromptPrefab, _Params.Content, itemIndex);
			systemPromptVh.SetImageAssetStation(_imageAssetStation);
			return systemPromptVh;
		}
		MissionMessageModel missionModel = sNSSessionMessageModel as MissionMessageModel;
		if (missionModel != null)
		{
			MissionVh missionVh = new MissionVh();
			missionVh.Init(_Params.missionPrefab, _Params.Content, itemIndex);
			missionVh.SetImageAssetStation(_imageAssetStation);
			missionVh.SetBtnListener(() =>
			{
				OnClickMission(missionModel);
			});
			return missionVh;
		}
		if (sNSSessionMessageModel is RewardMessageModel)
		{
			RewardVh rewardVh = new RewardVh();
			rewardVh.Init(_Params.rewardPrefab, _Params.Content, itemIndex);
			rewardVh.SetImageAssetStation(_imageAssetStation);
			return rewardVh;
		}
		if (sNSSessionMessageModel is EmptyModel)
		{
			EmptyVh emptyVh = new EmptyVh();
			emptyVh.Init(_Params.emptyPrefab, _Params.Content, itemIndex);
			emptyVh.SetImageAssetStation(_imageAssetStation);
			return emptyVh;
		}
		if (sNSSessionMessageModel is EndModel)
		{
			EndVh endVh = new EndVh();
			endVh.Init(_Params.endPrefab, _Params.Content, itemIndex);
			endVh.SetImageAssetStation(_imageAssetStation);
			return endVh;
		}
		return null;
	}

	public void OnClickMission(SNSSessionMessageModel model)
	{
		MissionMessageModel missionMessageModel = model as MissionMessageModel;
		if (missionMessageModel != null)
		{
			List<int> list = new List<int>();
			Singleton<MissionManager>.instance.GetAllMissions(list);
			int num = list.Find((int x) => x == missionMessageModel.MissionId);
			if (num != 0 && CoreUtils.GetData(missionMessageModel.MissionId, RuntimeConfigs.data.missionBases) != null)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TASK, new TaskViewV3Data
				{
					missionId = num
				});
			}
		}
	}

	protected override void UpdateViewsHolder(SNSSessionMessageVh newOrRecycled)
	{
		SNSSessionMessageModel sNSSessionMessageModel = data[newOrRecycled.ItemIndex];
		newOrRecycled.UpdateFormModel(sNSSessionMessageModel);
		if (sNSSessionMessageModel.HasPendingVisualSizeChange)
		{
			newOrRecycled.MarkForRebuild();
		}
		ScheduleComputeVisibilityTwinPass();
	}

	protected override bool IsRecyclable(SNSSessionMessageVh potentiallyRecyclable, int indexOfItemThatWillBecomeVisible, double sizeOfItemThatWillBecomeVisible)
	{
		return false;
	}

	protected override void OnItemHeightChangedPreTwinPass(SNSSessionMessageVh viewsHolder)
	{
		base.OnItemHeightChangedPreTwinPass(viewsHolder);
		data[viewsHolder.ItemIndex].HasPendingVisualSizeChange = false;
	}

	protected override void CollectItemsSizes(ItemCountChangeMode changeMode, int count, int indexIfInsertingOrRemoving, ItemsDescriptor itemsDesc)
	{
		base.CollectItemsSizes(changeMode, count, indexIfInsertingOrRemoving, itemsDesc);
		if (count == 0 || changeMode != ItemCountChangeMode.RESET)
		{
			return;
		}
		for (int i = 0; i < count; i++)
		{
			if (data[i] is SystemPromptMessageModel)
			{
				itemsDesc.BeginChangingItemsSizes(i);
				itemsDesc[i] = 100.0;
				itemsDesc.EndChangingItemsSizes();
			}
			if (data[i] is RewardMessageModel)
			{
				itemsDesc.BeginChangingItemsSizes(i);
				itemsDesc[i] = 225.0;
				itemsDesc.EndChangingItemsSizes();
			}
			if (data[i] is ImageMessageModel)
			{
				itemsDesc.BeginChangingItemsSizes(i);
				itemsDesc[i] = 400.0;
				itemsDesc.EndChangingItemsSizes();
			}
		}
	}

	public void OnOptionShow()
	{
		Parameters.ContentPadding.bottom = 50;
		ForceRebuildLayoutNow();
		ScrollToBottom();
	}

	public void OnOptionHide()
	{
		Parameters.ContentPadding.bottom = 50;
		ForceRebuildLayoutNow();
	}

	public void InsertNewMessage(long messageId, int sessionId, out int extraDelay)
	{
		int sessionIdForMessage = Model<SNSModel>.Interface.GetSessionIdForMessage(messageId, sessionId);
		SNSSessionMessageModel sNSSessionMessageModel = CreateModel(messageId, sessionIdForMessage, appear: false);
		if (sNSSessionMessageModel == null)
		{
			extraDelay = 0;
			return;
		}
		data.InsertOneAtEnd(sNSSessionMessageModel);
		if (messageId != 0L)
		{
			extraDelay = CoreUtils.GetData(messageId, RuntimeConfigs.data.messageConversations).messageDynamicEffectExtra;
		}
		else
		{
			extraDelay = 50;
		}
		ScrollToBottom();
		if (!sNSSessionMessageModel.OnRight)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Message/Receive");
		}
		MessageConversationGroup messageConversationGroup = CoreUtils.GetData(sessionIdForMessage, RuntimeConfigs.data.messageConversationGroups);
		MessageEvent evt = EventTrackSolver.Instance.GetEvt<MessageEvent>();
		evt.conversationCharacterId = messageConversationGroup.messageCharacterID;
		evt.conversationType = messageConversationGroup.Type;
		evt.conversationId = messageConversationGroup.id;
		evt.conversationStatus = 1;
		evt.messageId = messageId;
		evt.messageChooseId = 0;
		int messageType = ((!(sNSSessionMessageModel is EmptyModel)) ? ((sNSSessionMessageModel is ImageMessageModel) ? 2 : ((sNSSessionMessageModel is MissionMessageModel) ? 4 : ((sNSSessionMessageModel is FileMessageModel) ? 7 : ((sNSSessionMessageModel is EndModel) ? 8 : ((sNSSessionMessageModel is RewardMessageModel) ? 6 : ((sNSSessionMessageModel is SystemPromptMessageModel) ? 3 : ((sNSSessionMessageModel is TextMessageModel) ? 1 : 0))))))) : 0);
		evt.messageType = messageType;
		evt.status = 2;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void ScrollToBottom()
	{
		if (data.Count != 0)
		{
			ScrollTo(data.Count - 1, 0f, 0.5f);
		}
	}
}
