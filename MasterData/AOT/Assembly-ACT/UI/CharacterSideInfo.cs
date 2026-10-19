using ACT.Event;
using Bamboo.ECS;
using UnityEngine.EventSystems;

namespace UI;

public class CharacterSideInfo : UIBehaviour
{
	private int _characterId;

	private float _assistCost;

	public void Init(Entity entity)
	{
		SetTransform();
		_characterId = entity.GetCompCharacter().characterSource.Id();
		_assistCost = entity.GetCompAbility().AssistCost;
	}

	private void SetTransform()
	{
	}

	public void UnInit()
	{
	}

	public void OnCharacterHpChange(CharacterHpChangeEvt characterHpChangeEvt)
	{
	}
}
