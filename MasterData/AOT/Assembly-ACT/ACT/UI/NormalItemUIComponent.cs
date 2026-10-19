using UnityEngine;

namespace ACT.UI;

public class NormalItemUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private ActButton m_ReduceBtn;

	[SerializeField]
	private GameObject m_AddIcon;

	[SerializeField]
	private GameObject m_NotObtained;

	protected override void OnGameObjectAwake()
	{
		base.OnGameObjectAwake();
		if ((bool)m_ReduceBtn)
		{
			m_ReduceBtn.OnClick.AddListener(OnInvertClick);
		}
	}

	protected override void OnGameObjectDestroy()
	{
		base.OnGameObjectDestroy();
		if ((bool)m_ReduceBtn)
		{
			m_ReduceBtn.OnClick.RemoveListener(OnInvertClick);
		}
	}

	public void SetAddState(bool state)
	{
		m_AddIcon.SetActive(state);
	}

	public void SetNotObtainedState(bool state)
	{
		m_NotObtained.SetActive(state);
	}
}
