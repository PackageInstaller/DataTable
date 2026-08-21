using UnityEngine;
using UnityEngine.UI;

namespace Ase;

[RequireComponent(typeof(Image))]
public class BulletSquare : MonoBehaviour
{
	[SerializeField]
	private GameObject[] bulletTypes;

	[SerializeField]
	private Animation[] bulletAni;

	[SerializeField]
	private Image emtyBullet;

	private int curBulletType = -1;

	public void SetBulletType(int bulletType)
	{
		if (curBulletType == bulletType)
		{
			SetEmptyBulletShow(bulletType < 0);
			return;
		}
		SetEmptyBulletShow(bulletType < 0);
		if (curBulletType < 0 && bulletType >= 0)
		{
			if (!bulletTypes[bulletType].activeSelf)
			{
				bulletTypes[bulletType].SetActive(value: true);
			}
			bulletAni[bulletType].Play("Bullet_enter_1");
		}
		else if (curBulletType >= 0 && bulletType < 0)
		{
			if (!bulletTypes[curBulletType].activeSelf)
			{
				bulletTypes[curBulletType].SetActive(value: true);
			}
			bulletAni[curBulletType].Play("Bullet_out_1");
		}
		else if (curBulletType >= 0 && bulletType >= 0)
		{
			if (!bulletTypes[bulletType].activeSelf)
			{
				bulletTypes[bulletType].SetActive(value: true);
			}
			bulletAni[bulletType].Play("Bullet_enter_1");
			bulletTypes[curBulletType].SetActive(value: false);
		}
		curBulletType = bulletType;
	}

	private void SetEmptyBulletShow(bool isShow)
	{
		if (emtyBullet.enabled != isShow)
		{
			emtyBullet.enabled = isShow;
		}
	}
}
