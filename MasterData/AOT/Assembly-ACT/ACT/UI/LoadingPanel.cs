using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class LoadingPanel : UIBehaviour
{
	[SerializeReference]
	private Slider slider;

	private Instructions _load = new Instructions();

	private bool _state;

	public void Open()
	{
		_load.Clear();
		_state = false;
		_load.onUpdate += OnProgressUpdate;
		slider.value = _load.Percent;
		gameObject.SetActive(value: true);
	}

	public void Close()
	{
		_load.onUpdate -= OnProgressUpdate;
		AssetStationManager.RequestUnloadUnusedUnityAssets();
		_state = false;
		gameObject.SetActive(value: false);
	}

	public void AddInstruction(LoadInstruction loadInstruction, float weight)
	{
		_load.AddInstruction(loadInstruction, weight);
	}

	private void OnProgressUpdate()
	{
		slider.value = _load.Percent;
		_state = _load.GetAllLoadInstructionStatus();
	}
}
