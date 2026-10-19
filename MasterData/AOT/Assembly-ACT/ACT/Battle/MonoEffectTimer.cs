namespace ACT.Battle;

public class MonoEffectTimer : MonoEffect
{
	public float duration;

	public bool onEndSetToBeRemove;

	private EffectRuntimeItem m_Item;

	public override void StartEffect(EffectRuntimeItem item)
	{
		m_Item = item;
		controlRemove = true;
	}

	private void Update()
	{
		if (m_Item != null && m_Item.time > duration)
		{
			isDone = true;
			if (onEndSetToBeRemove)
			{
				m_Item.SetToBeRemove();
			}
		}
	}
}
