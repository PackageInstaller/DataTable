using ACT.World;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AreaMapSwitchLayerBtn : MonoBehaviour
{
	public AreaMapSwitchLayerBtnGroup group;

	public Animator animator;

	public Button btn;

	public TextMeshProUGUI normalText;

	public TextMeshProUGUI selectText;

	public MapLayer layer;

	public GameObject playerIcon;

	public GameObject missionIcon;

	private bool isSelect;

	public void Init(MapLayer layer)
	{
		this.layer = layer;
		btn.onClick.RemoveAllListeners();
		btn.onClick.AddListener(() =>
		{
			group.SwitchLayer(layer);
		});
		int value = (int)((layer >= MapLayer.L0) ? (layer + 1) : layer);
		normalText.text = value.FastToString();
		selectText.text = value.FastToString();
		SetPlayerIconActive(active: false);
		SetMissionIconActive(active: false);
	}

	public void UnInit()
	{
		SetPlayerIconActive(active: false);
		SetMissionIconActive(active: false);
	}

	public void Show(bool isSelect)
	{
		this.isSelect = isSelect;
		animator.Rebind();
		animator.Play(isSelect ? "LayerSelectedShow" : "LayerNormalShow", 0, 0f);
	}

	public void SetSelect(bool isSelect)
	{
		if (this.isSelect != isSelect)
		{
			this.isSelect = isSelect;
			animator.Rebind();
			animator.Play(isSelect ? "Select" : "LayerNormal");
		}
	}

	public void SetPlayerIconActive(bool active)
	{
		playerIcon.SetActive(active);
	}

	public void SetMissionIconActive(bool active)
	{
		missionIcon.SetActive(active);
	}
}
