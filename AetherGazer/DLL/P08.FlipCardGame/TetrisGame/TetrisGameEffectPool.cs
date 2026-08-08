using System.Collections.Generic;
using UnityEngine;

namespace TetrisGame;

public class TetrisGameEffectPool : MonoBehaviour
{
	[SerializeField]
	private GameObject effectOneGo;

	[SerializeField]
	private GameObject effectTwoGo;

	[SerializeField]
	private GameObject effectThreeGo;

	[SerializeField]
	private GameObject effectSkill1Go;

	[SerializeField]
	private GameObject effectSkill2Go;

	private Dictionary<EffectType, List<Animator>> effectAnimatorList;

	public RectTransform PlayEffect(EffectType type, int x, int y, Vector2 pos)
	{
		if (effectAnimatorList == null)
		{
			effectAnimatorList = new Dictionary<EffectType, List<Animator>>();
		}
		Animator animator = null;
		if (effectAnimatorList.ContainsKey(type))
		{
			foreach (Animator item in effectAnimatorList[type])
			{
				if (item.GetCurrentAnimatorStateInfo(0).normalizedTime >= 1f)
				{
					animator = item;
					break;
				}
			}
		}
		if (animator == null)
		{
			animator = CreateEffect(type);
		}
		animator.Play("UI_remove_cx", 0, 0f);
		animator.Update(0f);
		Transform parent = animator.transform.parent;
		RectTransform component = parent.GetComponent<RectTransform>();
		if (x >= 0)
		{
			parent.localEulerAngles = new Vector3(0f, 0f, 90f);
		}
		else
		{
			parent.localEulerAngles = Vector3.zero;
		}
		component.anchoredPosition = pos;
		return component;
	}

	public Animator CreateEffect(EffectType effectType)
	{
		GameObject gameObject = effectType switch
		{
			EffectType.One => Object.Instantiate(effectOneGo, base.transform), 
			EffectType.Two => Object.Instantiate(effectTwoGo, base.transform), 
			EffectType.Three => Object.Instantiate(effectThreeGo, base.transform), 
			EffectType.Skill1 => Object.Instantiate(effectSkill1Go, base.transform), 
			EffectType.Skill2 => Object.Instantiate(effectSkill2Go, base.transform), 
			_ => Object.Instantiate(effectSkill2Go, base.transform), 
		};
		Animator componentInChildren = gameObject.GetComponentInChildren<Animator>();
		if (effectAnimatorList.ContainsKey(effectType))
		{
			effectAnimatorList[effectType].Add(componentInChildren);
		}
		else
		{
			effectAnimatorList.Add(effectType, new List<Animator> { componentInChildren });
		}
		return gameObject.GetComponentInChildren<Animator>();
	}

	public void Dispose()
	{
		if (effectAnimatorList == null)
		{
			return;
		}
		foreach (List<Animator> value in effectAnimatorList.Values)
		{
			foreach (Animator item in value)
			{
				Object.Destroy(item.transform.parent.gameObject);
			}
		}
		effectAnimatorList = null;
	}
}
