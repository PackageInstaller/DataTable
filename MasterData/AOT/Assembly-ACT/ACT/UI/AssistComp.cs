using ACT.Battle;
using ACT.Event;
using ACT.Game.Data;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public abstract class AssistComp : UIBehaviour
{
	protected AssistData _data;

	public virtual void Init(AssistData assistData, CustomUITransform transform, Entity entity)
	{
		SetTransform(transform);
		_data = assistData;
		_data.OnAssistPercentChanged += SetVal;
		_data.OnCharacterAssistActiveChange += OnCharacterAssistActiveChange;
		SetValOnInit();
		if (MonoECS.instance.sceneStatus == SceneStatus.Rogue)
		{
			gameObject.SetActive(value: false);
		}
	}

	private void OnCharacterAssistActiveChange(CharacterAssistActiveChangeEvt evt)
	{
		gameObject.SetActive(evt.active);
	}

	public virtual void UnInit()
	{
		_data.OnAssistPercentChanged -= SetVal;
		_data.OnCharacterAssistActiveChange -= OnCharacterAssistActiveChange;
	}

	public void OnUpdateScheme(CustomUITransform transform)
	{
		SetTransform(transform);
	}

	private void SetTransform(CustomUITransform transform)
	{
		RectTransform obj = base.transform as RectTransform;
		obj.anchoredPosition = transform.Pos;
		obj.sizeDelta = transform.Diameter * Vector2.one;
	}

	public void SetActive(bool active)
	{
		gameObject.SetActive(active);
	}

	protected virtual void SetValOnInit()
	{
	}

	protected virtual void SetVal(float val)
	{
	}

	public virtual void OnCharacterChange(Entity eb)
	{
	}
}
