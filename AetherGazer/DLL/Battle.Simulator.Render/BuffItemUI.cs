using System.Collections.Generic;
using Config;
using UnityEngine;
using UnityEngine.UI;

public class BuffItemUI : MonoBehaviour
{
	public Image _icon;

	public Image _background;

	public Animator _animator;

	public bool _isPlayEndEffect;

	public int _playEffectTime = 1000;

	public void Awake()
	{
		_icon = base.transform.Find("Icon").GetComponent<Image>();
		_background = GetComponent<Image>();
		_animator = GetComponent<Animator>();
	}

	public void SetIcon(string path)
	{
		if (!(null != _icon.sprite) || !(_icon.sprite.name == path))
		{
			_icon.sprite = AtlasManager.GetSpriteWithoutAtlas("TextureConfig/BuffIcon/" + path);
		}
	}

	public void SetActive(bool visible)
	{
		if (base.gameObject.activeSelf != visible)
		{
			base.gameObject.SetActive(visible);
		}
	}

	public void SetCD(float amount)
	{
		_background.fillAmount = amount;
	}

	public static void UpdateBuffCD(List<BuffState> buffStates, List<BuffItemUI> buffItems)
	{
		if (buffStates == null || buffItems == null)
		{
			return;
		}
		for (int i = 0; i < buffStates.Count; i++)
		{
			BuffState buffState = buffStates[i];
			if (i >= buffItems.Count)
			{
				continue;
			}
			float cD = (float)buffState.mDuring / (float)buffState.mBuffKeepTime;
			buffItems[i].SetCD(cD);
			if (buffState.mDuring <= buffItems[i]._playEffectTime)
			{
				if (!buffItems[i]._isPlayEndEffect)
				{
					buffItems[i]._animator?.Play("EndEffect");
					buffItems[i]._isPlayEndEffect = true;
				}
			}
			else
			{
				buffItems[i]._isPlayEndEffect = false;
			}
		}
	}

	public static void UpdateBuffList(List<BuffState> buffStates, List<BuffItemUI> buffItems, string tag, List<string> temp)
	{
		if (buffStates == null || buffItems == null)
		{
			return;
		}
		temp.Clear();
		int num = 0;
		for (int i = 0; i < buffStates.Count; i++)
		{
			BuffState buffState = buffStates[i];
			if (num < buffItems.Count && ConfigHelper.GetInstance().HasConfig<public_buff>(buffState.mBuffConfigID))
			{
				public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(buffState.mBuffConfigID);
				if (config != null && tag == config.Type && !string.IsNullOrEmpty(config.Icon) && !temp.Contains(config.Icon))
				{
					buffItems[num].SetActive(visible: true);
					buffItems[num].SetIcon(config.Icon);
					temp.Add(config.Icon);
					num++;
				}
			}
		}
		for (int j = num; j < buffItems.Count; j++)
		{
			buffItems[j].SetActive(visible: false);
		}
	}
}
