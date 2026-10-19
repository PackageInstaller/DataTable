using System.Collections.Generic;
using ACT.Model;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class SNSPreOpenView : BaseUIView<SNSPreOpenViewInputController>
{
	private static readonly Queue<SNSModel.SpecificMsg> s_pendingMessages = new Queue<SNSModel.SpecificMsg>();

	private static bool s_isShowing;

	private SNSModel.SpecificMsg _firstMessage;

	private bool _hasFirstMessage;

	[SerializeField]
	public BImage contactsHeadIcon;

	[SerializeField]
	public LocalizeStringEvent receivedTips;

	protected SNSBaseViewData m_data;

	public static Queue<SNSModel.SpecificMsg> PendingMessages => s_pendingMessages;

	public static void Enqueue(SNSModel.SpecificMsg message)
	{
		s_pendingMessages.Enqueue(message);
	}

	public static void OpenView()
	{
		if (!s_isShowing && s_pendingMessages.Count != 0)
		{
			s_isShowing = true;
			Model<SNSModel>.Interface.NewMessagesQueue.Clear();
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SNSPREOPEN).Forget();
		}
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
	}

	protected override void PlayOpenAnimation()
	{
		if (s_isShowing)
		{
			base.PlayOpenAnimation();
			PlayNextMessageAnimation();
			return;
		}
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	private void PlayNextMessageAnimation()
	{
		if (!s_pendingMessages.TryDequeue(out var result))
		{
			OpenSNS();
			return;
		}
		if (!_hasFirstMessage)
		{
			_firstMessage = result;
			_hasFirstMessage = true;
		}
		SNSModel.SnsContacts contacts = Model<SNSModel>.Interface.GetContacts(result.ContactId);
		if (contacts != null)
		{
			Station.LoadImage(contacts.Icon.GroupId, contacts.Icon.ImageId, contactsHeadIcon);
		}
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Message/NewMessage_Modal");
		betterAnimation.GetSequence("Show")?.OnComplete((AnimationBuilder _) =>
		{
			PlayNextMessageAnimation();
		}).Play();
	}

	private async UniTaskVoid DelayPlayNextMessageAnimation()
	{
		await UniTask.Delay(2000);
		PlayNextMessageAnimation();
	}

	private void OpenSNS()
	{
		s_isShowing = false;
		OpenEffectFinishNew();
		if (_hasFirstMessage)
		{
			Model<SNSModel>.Interface.SetSpecificMsg(_firstMessage, needUnlock: true);
		}
		Close();
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SNS).Forget();
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
