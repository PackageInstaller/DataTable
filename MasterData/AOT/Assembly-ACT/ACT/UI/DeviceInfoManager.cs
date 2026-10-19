using System;
using System.Collections;
using ACT.Battle;
using ACT.Event;
using Fundamental;
using TMPro;
using UnityEngine;
using bamboosdk;

namespace ACT.UI;

public class DeviceInfoManager : MonoBehaviour, IUIFrameElement
{
	public BatteryInfo battery;

	public WifiInfo wifi;

	public DataInfo data;

	public TMP_Text clock;

	private Coroutine m_CoUpdate;

	public void Initialize()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Device_Battery, SetBattery);
		if (Application.internetReachability == NetworkReachability.NotReachable)
		{
			wifi.mainImage.gameObject.SetActive(value: false);
			data.mainImage.gameObject.SetActive(value: false);
		}
		if (Application.internetReachability == NetworkReachability.ReachableViaLocalAreaNetwork)
		{
			wifi.mainImage.gameObject.SetActive(value: true);
			data.mainImage.gameObject.SetActive(value: true);
		}
		if (Application.internetReachability == NetworkReachability.ReachableViaCarrierDataNetwork)
		{
			wifi.mainImage.gameObject.SetActive(value: false);
			data.mainImage.gameObject.SetActive(value: true);
		}
		m_CoUpdate = StartCoroutine(CoUpdate());
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Device_Battery, SetBattery);
		if (m_CoUpdate != null)
		{
			StopCoroutine(m_CoUpdate);
		}
	}

	private IEnumerator CoUpdate()
	{
		while (true)
		{
			try
			{
				clock.text = TimeManager.GetDateTimeString(TimeManager.LocalTime.Now, "HH:mm");
				wifi.SetValue((int)MonoECS.instance.pingTimeOffset);
				data.SetValue((int)MonoECS.instance.pingTimeOffset);
				GetBatteryViaSdk();
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
			yield return new WaitForSeconds(1f);
		}
	}

	private void GetBatteryViaSdk()
	{
		BamBooSdk.getInstance().getExtend("battery_power");
	}

	private void SetBattery(BaseEventContent e)
	{
		if (e is BatterStatusEvt batterStatusEvt)
		{
			battery.SetValue(batterStatusEvt.power);
		}
	}
}
