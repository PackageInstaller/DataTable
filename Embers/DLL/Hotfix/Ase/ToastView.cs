using GameFramework.Runtime;
using UnityEngine.UI;

namespace Ase;

public class ToastView : UIView
{
	public Text text;

	public float height;

	protected string configData;

	public virtual string ConfigData
	{
		get
		{
			return configData;
		}
		set
		{
			configData = value;
		}
	}
}
