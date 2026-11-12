using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[CreateAssetMenu(fileName = "Combo Group", menuName = "游戏/动作/连击动作组")]
public class ComboGroup : ScriptableObject
{
	public Combo.ComboMode comboMode;

	public Combo[] combos;

	public AvatarMask upperBodyAvatarMask;

	public List<AnimatorOverrideController> replaceOverrideController;

	public List<RuntimeAnimatorController> replaceRuntimeAnimatorController;

	public ComboClip aimStartAnimClip;

	public ComboClip aimAnimClip;

	public ComboClip[] aimAnimClip_other;

	public ComboClip reloadAnimClip;

	public ComboClip[] reloadAnimClip_Other;

	public string commonHittedEffectAlias;

	public bool useSceneMoveAnimationMotion;

	public FP sceneMoveAnimationMotionTime;

	public Combo.Event switchInEffect = new Combo.Event(Combo.Event.EventType.Effect, isSimpleMode: true);

	public Combo.Event switchOutEffect = new Combo.Event(Combo.Event.EventType.Effect, isSimpleMode: true);

	public string timelineAlias;

	public string timelineAliasN;

	public string timelineAlias_1;

	public string timelineAliasN_1;

	public string timelineAlias_2;

	public string timelineAliasN_2;

	public string timelineAlias_3;

	public string timelineAliasN_3;

	public string[] monsterTimelineAlias;

	public ActorRelatedResourceConfig relatedResourceConfig;

	public void LoadAnimations(HybirdAnimatorController animatorController)
	{
		if (upperBodyAvatarMask != null)
		{
			animatorController.SetActionAnimationAvatarMask(upperBodyAvatarMask);
		}
		if (aimStartAnimClip != null && aimStartAnimClip.animationClip != null)
		{
			animatorController.AddActionAnimationClip(aimStartAnimClip.animationClip, aimStartAnimClip.actionAnimType);
		}
		if (aimAnimClip != null && aimAnimClip.animationClip != null)
		{
			animatorController.AddActionAnimationClip(aimAnimClip.animationClip, aimAnimClip.actionAnimType);
		}
		if (aimAnimClip_other != null && aimAnimClip_other.Length != 0)
		{
			for (int i = 0; i < aimAnimClip_other.Length; i++)
			{
				ComboClip comboClip = aimAnimClip_other[i];
				if (comboClip != null && comboClip.animationClip != null)
				{
					animatorController.AddActionAnimationClip(comboClip.animationClip, comboClip.actionAnimType);
				}
			}
		}
		if (reloadAnimClip != null && reloadAnimClip.animationClip != null)
		{
			animatorController.AddActionAnimationClip(reloadAnimClip.animationClip, reloadAnimClip.actionAnimType);
		}
		if (reloadAnimClip_Other != null && reloadAnimClip_Other.Length != 0)
		{
			for (int j = 0; j < reloadAnimClip_Other.Length; j++)
			{
				ComboClip comboClip2 = reloadAnimClip_Other[j];
				if (comboClip2 != null && comboClip2.animationClip != null)
				{
					animatorController.AddActionAnimationClip(comboClip2.animationClip, comboClip2.actionAnimType);
				}
			}
		}
		for (int k = 0; k < combos.Length; k++)
		{
			Combo combo = combos[k];
			if (combo.compositeComboClips == null || !combo.autoLoad)
			{
				continue;
			}
			for (int l = 0; l < combo.compositeComboClips.Length; l++)
			{
				Combo.CompositeComboClip compositeComboClip = combo.compositeComboClips[l];
				if (compositeComboClip != null && compositeComboClip.comboClip != null && compositeComboClip.comboClip.animationClip != null)
				{
					animatorController.AddActionAnimationClip(compositeComboClip.comboClip.animationClip, compositeComboClip.comboClip.actionAnimType);
				}
			}
		}
	}

	public void LoadExtendAnimation(HybirdAnimatorController animatorController)
	{
		for (int i = 0; i < combos.Length; i++)
		{
			Combo combo = combos[i];
			if (combo.compositeComboClips == null || combo.autoLoad)
			{
				continue;
			}
			for (int j = 0; j < combo.compositeComboClips.Length; j++)
			{
				Combo.CompositeComboClip compositeComboClip = combo.compositeComboClips[j];
				if (compositeComboClip != null && compositeComboClip.comboClip != null && compositeComboClip.comboClip.animationClip != null)
				{
					animatorController.AddActionAnimationClip(compositeComboClip.comboClip.animationClip, compositeComboClip.comboClip.actionAnimType);
				}
			}
		}
	}
}
