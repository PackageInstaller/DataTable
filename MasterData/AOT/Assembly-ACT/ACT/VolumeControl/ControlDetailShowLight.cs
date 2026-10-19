using ACT.Event;
using ACT.UI;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.VolumeControl;

public class ControlDetailShowLight : UIBehaviour
{
	public GameObject idlePrefab;

	private MonoCharacterView view;

	protected override void Start()
	{
	}

	private void WhenPageChangeToShowModel(BaseEventContent obj)
	{
	}

	protected override void OnDisable()
	{
	}
}
