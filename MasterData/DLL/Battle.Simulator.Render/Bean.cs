using UnityEngine;

public class Bean : MonoBehaviour
{
	private bool _enable = true;

	private BeanAnimationController _in;

	private BeanAnimationController _out;

	private void Awake()
	{
		_in = U3DUtil.Get<BeanAnimationController>(base.transform.Find("progress").gameObject);
		_out = U3DUtil.Get<BeanAnimationController>(base.transform.Find("out").gameObject);
		_in.Init();
		_out.Init();
		_in.enabled = false;
		_out.enabled = false;
	}

	public void SetEnable(bool enable)
	{
		if (_enable != enable && null != _in && null != _out)
		{
			if (enable)
			{
				_in.SetEnable(enable: true);
				_out.SetEnable(enable: false);
			}
			else
			{
				_in.SetEnable(enable: false);
				_out.SetEnable(enable: true);
			}
			_enable = enable;
		}
	}
}
