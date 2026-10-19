using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Timeline;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class CompEffect : EcsComponent
{
	public List<EffectRuntimeItem> myEffects;

	public List<EffectRuntimeItem> playEffects;

	private bool _effectsHidden;

	public Dictionary<int, TimelineBase> myTimeLines;

	public bool bInUltraTimeline;

	public Dictionary<string, RayHitEffectInfo> rayEffectInfos;

	public Dictionary<string, EffectTran> customEffectTran;

	private readonly EffectDressRuntimeState _effectDressState = new EffectDressRuntimeState();

	public bool EffectsHidden => _effectsHidden;

	public EffectDressRuntimeState EffectDressState => _effectDressState;

	public void SetAllEffectsVisible(bool visible)
	{
		_effectsHidden = !visible;
		for (int i = 0; i < myEffects.Count; i++)
		{
			myEffects[i].SetOwnerVisible(visible);
		}
		for (int j = 0; j < playEffects.Count; j++)
		{
			playEffects[j].SetOwnerVisible(visible);
		}
	}

	public CompEffect()
	{
		myEffects = new List<EffectRuntimeItem>();
		playEffects = new List<EffectRuntimeItem>();
		rayEffectInfos = new Dictionary<string, RayHitEffectInfo>();
		customEffectTran = new Dictionary<string, EffectTran>();
		myTimeLines = new Dictionary<int, TimelineBase>();
	}

	protected override void OnGet()
	{
		RegisterEffectDressEvents();
	}

	protected override void OnRelease()
	{
		ReleaseEffectDress();
		foreach (EffectRuntimeItem myEffect in myEffects)
		{
			myEffect.RemoveImmediately();
		}
		myEffects.Clear();
		foreach (EffectRuntimeItem playEffect in playEffects)
		{
			playEffect.removeWhenStop = true;
			playEffect.SetToBeRemove();
		}
		playEffects.Clear();
		_effectsHidden = false;
		rayEffectInfos.Clear();
		foreach (KeyValuePair<int, TimelineBase> myTimeLine in myTimeLines)
		{
			myTimeLine.Value.StopTimeline();
		}
		myTimeLines.Clear();
		bInUltraTimeline = false;
		foreach (KeyValuePair<string, EffectTran> item in customEffectTran)
		{
			EffectTran.EffectTranPool.Release(item.Value);
		}
		customEffectTran.Clear();
	}

	public EffectRuntimeItem GetEffect(string effectName)
	{
		foreach (EffectRuntimeItem myEffect in myEffects)
		{
			if (myEffect.effectName == effectName)
			{
				return myEffect;
			}
		}
		return null;
	}

	public void RemoveIllogicalEffects()
	{
		foreach (EffectRuntimeItem myEffect in myEffects)
		{
			if (!myEffect.isAttach && myEffect.removeWhenMotionExit == MotionState.None && string.IsNullOrEmpty(myEffect.removeWhenConfigMotionExit))
			{
				myEffect.SetToBeRemove();
			}
		}
	}

	private void RegisterEffectDressEvents()
	{
		Singleton<EventManager>.instance?.AddEventListener(ClientEvent.SwitchEffectDress, OnSwitchEffectDress);
	}

	private void ReleaseEffectDress()
	{
		Singleton<EventManager>.instance?.RemoveEventListener(ClientEvent.SwitchEffectDress, OnSwitchEffectDress);
		EffectDressRuntimeUtility.ClearAll(_effectDressState);
		_effectDressState.Reset();
	}

	private void OnSwitchEffectDress(BaseEventContent content)
	{
		if (owner.IsValid && (!(content is SwitchEffectDressEvt { roleId: not 0 } switchEffectDressEvt) || (owner.TryGetCompCharacter(out CompCharacter component) && component.characterSource?.Id() == switchEffectDressEvt.roleId)))
		{
			EffectDressRuntimeUtility.SyncDressFromCharacter(owner);
		}
	}
}
