using Config;
using UnityEngine;
using UnityEngine.UI;

public class QTEPowerUI : MonoBehaviour
{
	public Text Desc;

	public Image Power;

	public Image Backgound;

	public Image Level;

	public GameObject[] Decorate;

	private int _increasePower;

	private string _descTemplate = "";

	private BBHumanoid _blackboard;

	private int _buffConfigID;

	private Sprite[] _sprites = new Sprite[3];

	public void OnMainPlayerUpdate(NAgent agent)
	{
	}

	public void Update()
	{
		if (null == _blackboard || _blackboard.m_NextSimFrameData == null || _blackboard.m_LastSimFrameData == null)
		{
			return;
		}
		for (int i = 0; i < _blackboard.m_NextSimFrameData.BuffStateArray.Count; i++)
		{
			BuffState buffState = _blackboard.m_NextSimFrameData.BuffStateArray[i];
			if (buffState.mBuffConfigID == _buffConfigID)
			{
				public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(_buffConfigID);
				if (_increasePower != buffState.mFloor)
				{
					Desc.text = string.Format(_descTemplate, (buffState.mFloor - 1) * config.BuffparamFactor.get_Item(1) + config.BuffparamBase.get_Item(1));
					Level.sprite = _sprites[buffState.mFloor - 1];
					_increasePower = buffState.mFloor;
				}
				Power.fillAmount = (float)buffState.mDuring * 1f / (float)config.KeepTime;
				SetVisible(visible: true);
				return;
			}
		}
		_increasePower = 0;
		SetVisible(visible: false);
	}

	private void SetVisible(bool visible)
	{
		Desc.enabled = visible;
		Power.enabled = visible;
		Backgound.enabled = visible;
		Level.enabled = visible;
		for (int i = 0; i < Decorate.Length; i++)
		{
			Decorate[i].SetActive(visible);
		}
	}
}
