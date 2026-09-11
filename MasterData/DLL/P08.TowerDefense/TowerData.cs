public class TowerData : IFramePooledObject
{
	public int m_body;

	public int m_bodyUpgrade;

	public int[] m_weaponArr;

	public int[] m_weaponUpgradeArr;

	public int m_recycle;

	public void OnEnterPool()
	{
		m_body = 0;
		m_bodyUpgrade = 0;
		m_weaponArr = null;
		m_weaponUpgradeArr = null;
		m_recycle = 0;
	}
}
