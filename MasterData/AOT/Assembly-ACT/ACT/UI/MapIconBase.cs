using ACT.World;
using UnityEngine;

namespace ACT.UI;

public class MapIconBase : MonoBehaviour
{
	public MapIconType type;

	public MapArea mapArea;

	public virtual void UnInit()
	{
	}

	protected virtual void LoadSprite(int spriteId)
	{
	}

	public virtual void UpdateScale(float mapScale)
	{
	}

	public void SetPos(Vector2 pos)
	{
		RectTransform obj = transform as RectTransform;
		obj.anchoredPosition3D = Vector3.zero;
		obj.anchoredPosition = pos;
		obj.localScale = Vector3.one;
	}

	public virtual void SetScale(float val)
	{
		transform.localScale = Vector3.one * val;
	}

	public virtual void SetIsTrack(bool isTrack)
	{
	}

	public virtual void SetIsFade(bool fade)
	{
	}

	public virtual int GetId()
	{
		return 0;
	}
}
