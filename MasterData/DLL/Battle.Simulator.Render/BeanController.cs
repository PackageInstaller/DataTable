using System.Collections.Generic;
using UnityEngine;

public class BeanController : MonoBehaviour, IPowerController
{
	public List<Bean> Beans = new List<Bean>(6);

	public List<GameObject> Backgrounds = new List<GameObject>(6);

	private int _currentCount = -1;

	private void Awake()
	{
		for (int i = 0; i < Beans.Count; i++)
		{
			Beans[i].SetEnable(enable: false);
			Beans[i].gameObject.SetActive(value: false);
			Backgrounds[i].gameObject.SetActive(value: false);
		}
	}

	public void SetActive(bool active)
	{
		base.gameObject.SetActive(active);
	}

	public void UpdatePowerMax(int max)
	{
		for (int i = 0; i < Beans.Count; i++)
		{
			if (i >= max)
			{
				Beans[i].SetEnable(enable: true);
			}
			Beans[i].gameObject.SetActive(i < max);
			Beans[i].SetEnable(i < _currentCount);
			Backgrounds[i].gameObject.SetActive(i < max);
		}
	}

	public void SetPower(int power, int max)
	{
		if (_currentCount != power)
		{
			_currentCount = power;
			for (int i = 0; i < Beans.Count; i++)
			{
				Beans[i].SetEnable(i < power);
			}
		}
	}

	public void SetSlowPower(int power, int max)
	{
	}
}
