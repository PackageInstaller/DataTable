using System;
using System.Collections.Generic;
using Ase;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class BattleEmoteView : UGuiView, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	private List<EmoteViewItem> _emoteList = new List<EmoteViewItem>();

	private Dictionary<int, ShowEmoteData> _showEmoteCommandDic = new Dictionary<int, ShowEmoteData>();

	public GameObject root;

	public GameObject emoteBack;

	public GameObject emotePrefab;

	public GameObject showEmotePrefab;

	public Image pointDownImage;

	private Queue<GameObject> _playerShowEmote = new Queue<GameObject>();

	public float radius;

	public float startDistance = 400f;

	public float endDistance = 500f;

	public Vector3 uiOffset;

	public float pointerDownTime = 0.5f;

	public float refreshSendTime = 5f;

	public float prohibitionSendTime = 5f;

	public int maxSendTime = 3;

	public GameObject prohibitionGo;

	public float prohibitionShowTime = 1f;

	private float _deg;

	public float halfDeg;

	public float showEmoteTime;

	public float gradientsTime = 0.1f;

	public float emoteMoveSpeed = 80f;

	private float _time;

	private bool _isOpenDown;

	private BattleEmoteViewModel _battleEmoteViewModel;

	private bool _isShowed;

	protected override void OnInit(object userData)
	{
		base.OnInit(userData);
		_battleEmoteViewModel = GetUserData<BattleEmoteViewModel>(userData);
		BindingSet<BattleEmoteView, BattleEmoteViewModel> bindingSet = this.CreateBindingSet(_battleEmoteViewModel);
		if (_battleEmoteViewModel.IsOpen)
		{
			bindingSet.Bind(this).For((BattleEmoteView v) => v.HideWindow).To((BattleEmoteViewModel vm) => vm.SendEmoteRequest);
			bindingSet.Bind(this).For((BattleEmoteView v) => v.ShowEmote).To((BattleEmoteViewModel vm) => vm.ShowEmoteRequest);
		}
		bindingSet.Bind(pointDownImage).For((Image v) => v.raycastTarget).To((BattleEmoteViewModel vm) => vm.IsOpen);
		bindingSet.Bind(prohibitionGo).For((GameObject v) => v.activeSelf).To((BattleEmoteViewModel vm) => vm.IsShowProhibitionTitle);
		bindingSet.Build();
		if (_battleEmoteViewModel.IsOpen)
		{
			_battleEmoteViewModel.InitData(refreshSendTime, prohibitionSendTime, maxSendTime, prohibitionShowTime);
			InitEmoteItem(_battleEmoteViewModel);
			for (int num = 0; num < 3; num++)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(showEmotePrefab);
				gameObject.transform.SetParent(base.transform);
				gameObject.transform.SetAsFirstSibling();
				gameObject.transform.localScale = Vector3.one;
				_playerShowEmote.Enqueue(gameObject);
			}
		}
	}

	public void InitEmoteItem(BattleEmoteViewModel battleEmoteViewModel)
	{
		_deg = 360f / (float)battleEmoteViewModel.BattleEmoteModels.Count;
		for (int i = 0; i < battleEmoteViewModel.BattleEmoteModels.Count; i++)
		{
			if (!battleEmoteViewModel.BattleEmoteModels[i].IsNull)
			{
				GameObject obj = UnityEngine.Object.Instantiate(emotePrefab);
				float f = (float)((double)(halfDeg + (float)i * _deg) * (Math.PI / 180.0));
				float x = Mathf.Sin(f) * radius;
				float y = Mathf.Cos(f) * radius;
				obj.transform.SetParent(emoteBack.transform);
				obj.transform.localScale = Vector3.one;
				obj.GetComponent<RectTransform>().anchoredPosition = new Vector3(x, y, 0f);
				obj.GetComponent<RectTransform>().eulerAngles = new Vector3(0f, 0f, (0f - _deg) * (float)i);
				EmoteViewItem component = obj.GetComponent<EmoteViewItem>();
				component?.Init(battleEmoteViewModel.BattleEmoteModels[i]);
				component?.InitRotate(_deg * (float)i);
				component?.InitParentWindow(this);
				_emoteList.Add(component);
			}
		}
	}

	private void ShowWindow()
	{
		if (!(root == null) && !root.activeSelf)
		{
			root.SetActive(value: true);
			_isShowed = true;
		}
	}

	private void HideWindow(object sender, InteractionEventArgs e)
	{
		if (!(root == null))
		{
			root.SetActive(value: false);
			for (int i = 0; i < _emoteList.Count; i++)
			{
				_emoteList[i].RefreshImage();
			}
		}
	}

	public void RefreshImage(int ignoreEmoteIndex)
	{
		for (int i = 0; i < _emoteList.Count; i++)
		{
			if (_emoteList[i].EmoteConfigId != ignoreEmoteIndex)
			{
				_emoteList[i].RefreshImage();
			}
		}
	}

	private void SendEmote()
	{
		_battleEmoteViewModel.SendEmote();
	}

	private void ShowEmote(object sender, InteractionEventArgs e)
	{
		if (e.Context == null)
		{
			return;
		}
		TempEmoteData tempEmoteData = (TempEmoteData)e.Context;
		if (tempEmoteData.HeroEntity != null && !(tempEmoteData.EmoteSprite == null))
		{
			if (!_showEmoteCommandDic.TryGetValue(tempEmoteData.HeroEntity.Id, out var value))
			{
				ShowEmoteData showEmoteData = ReferencePool.Acquire<ShowEmoteData>();
				GameObject gameObject = _playerShowEmote.Dequeue();
				showEmoteData.RefreshEmoteData(showEmoteTime, gradientsTime, uiOffset, emoteMoveSpeed);
				Camera battleCamera = _battleEmoteViewModel?.SelfEntity?.GetSystem<CameraSystem>()?.BattleCamera;
				showEmoteData.InitCommand(gameObject.GetComponent<Image>(), tempEmoteData.EmoteSprite, tempEmoteData.HeroEntity, battleCamera);
				_showEmoteCommandDic.Add(tempEmoteData.HeroEntity.Id, showEmoteData);
			}
			else
			{
				value.RefreshEmoteData(showEmoteTime, gradientsTime, uiOffset, emoteMoveSpeed);
				value.RefreshTime(showEmoteTime, tempEmoteData.EmoteSprite);
			}
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		_isOpenDown = true;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		_isOpenDown = false;
		_time = 0f;
		HideWindow(null, null);
		SendEmote();
		_isShowed = false;
	}

	public void Update()
	{
		OnEmoteWindowMouseUp();
		_battleEmoteViewModel?.Update(0.016f);
		ShowPlayerEmoteImage();
		if (_isOpenDown)
		{
			_time += Time.deltaTime;
			if (_time >= pointerDownTime)
			{
				ShowWindow();
				_battleEmoteViewModel.SetShowFlag();
			}
		}
	}

	private void ShowPlayerEmoteImage()
	{
		foreach (ShowEmoteData value in _showEmoteCommandDic.Values)
		{
			value?.Update(0.016f);
		}
	}

	private bool OnEmoteWindowMouseUp()
	{
		if (!_isShowed)
		{
			return false;
		}
		Vector2 anchoredPosition = base.transform.GetComponent<RectTransform>().anchoredPosition;
		Vector2 vector = new Vector2(Input.mousePosition.x - (float)(Screen.width / 2), Input.mousePosition.y - (float)(Screen.height / 2));
		float num = Vector2.SqrMagnitude(vector - anchoredPosition);
		if (num > startDistance * startDistance && num < endDistance * endDistance)
		{
			float value = TSUtil.Vector2Angle((vector - anchoredPosition).normalized);
			value = TSUtil.Angle2Limit(value);
			foreach (EmoteViewItem emote in _emoteList)
			{
				if (value >= emote.BattleEmoteModel.StartDeg && value < emote.BattleEmoteModel.EndDeg)
				{
					emote.HighLight();
					return true;
				}
			}
		}
		return false;
	}
}
