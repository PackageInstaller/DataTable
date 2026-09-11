using Chess;
using UnityEngine;

internal class HexBulletManager
{
	private static HexBulletManager sInstance;

	public string bulletAssetPath;

	public static HexBulletManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new HexBulletManager();
			}
			return sInstance;
		}
	}

	public void Init(string bulletPath)
	{
		bulletAssetPath = bulletPath;
		Asset.Cache(bulletAssetPath);
	}

	public void FireBullet(int x, int z, int direction)
	{
		GameObject gameObject = Asset.Instantiate(bulletAssetPath);
		Vector3 position = HexManager.Instance.FindEntity(x, z).go.transform.position;
		gameObject.transform.position = ChessHelper.GetFirePointByDirection(position, direction);
		HexBullet component = gameObject.GetComponent<HexBullet>();
		Transform[] targetS = new Transform[1] { gameObject.transform };
		HexCameraManager.Instance.LookAtTargetS(targetS);
		if (component != null)
		{
			component.Fire(ChessHelper.GetFireEndPoint(x, z, direction, out var endPointCoord), delegate
			{
				int num = (direction + 3) % 6;
				HexEntity hexEntity = HexManager.Instance.FindEntity(endPointCoord.x, endPointCoord.y);
				LuaHelper.CallFunction("OnBulletHit", endPointCoord.x, endPointCoord.y, num, hexEntity?.gridData);
			});
		}
	}
}
