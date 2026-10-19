using System;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Utilities;

internal class ForDeviceEventObservable : IObservable<InputEventPtr>
{
	private class ForDevice : IObserver<InputEventPtr>
	{
		private IObserver<InputEventPtr> m_Observer;

		private InputDevice m_Device;

		private Type m_DeviceType;

		public ForDevice(Type deviceType, InputDevice device, IObserver<InputEventPtr> observer)
		{
			m_Device = device;
			m_DeviceType = deviceType;
			m_Observer = observer;
		}

		public void OnCompleted()
		{
		}

		public void OnError(Exception error)
		{
			Debug.LogException(error);
		}

		public void OnNext(InputEventPtr value)
		{
			if (m_DeviceType != null)
			{
				InputDevice deviceById = InputSystem.GetDeviceById(value.deviceId);
				if (deviceById == null || !m_DeviceType.IsInstanceOfType(deviceById))
				{
					return;
				}
			}
			if (m_Device == null || value.deviceId == m_Device.deviceId)
			{
				m_Observer.OnNext(value);
			}
		}
	}

	private IObservable<InputEventPtr> m_Source;

	private InputDevice m_Device;

	private Type m_DeviceType;

	public ForDeviceEventObservable(IObservable<InputEventPtr> source, Type deviceType, InputDevice device)
	{
		m_Source = source;
		m_DeviceType = deviceType;
		m_Device = device;
	}

	public IDisposable Subscribe(IObserver<InputEventPtr> observer)
	{
		return m_Source.Subscribe(new ForDevice(m_DeviceType, m_Device, observer));
	}
}
