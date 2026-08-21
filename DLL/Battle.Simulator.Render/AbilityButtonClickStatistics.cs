using UnityEngine;
using UnityEngine.EventSystems;

public class AbilityButtonClickStatistics : MonoBehaviour, IPointerDownHandler, IEventSystemHandler
{
	[SerializeField]
	private ButtonType _buttonType = ButtonType.MELEE;

	private WorldStateManager _worldStateManager;

	private void Awake()
	{
		AttackButton component = GetComponent<AttackButton>();
		if (null != component)
		{
			_buttonType = component.ButtonType;
		}
		_worldStateManager = ((BattleScene)NScene.GetCurrentScene()).GetWorldSatetManager();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (_worldStateManager != null)
		{
			_worldStateManager.ClickStaticsData.Add((int)_buttonType);
		}
	}
}
