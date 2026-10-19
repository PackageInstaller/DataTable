using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

public static class CharacterRenderingRegistry
{
	public struct Settings
	{
		public bool enableHDShadow;

		public Quaternion mainLightRotation;

		public static Settings defaultValue => new Settings
		{
			enableHDShadow = true,
			mainLightRotation = Quaternion.identity
		};
	}

	public sealed class Registration
	{
		internal readonly int RegistrationId;

		internal GameObject Owner;

		internal Renderer[] Renderers;

		internal HDShadow.HDTarget Target;

		internal Settings CurrentSettings;

		public GameObject owner => Owner;

		public bool isValid => Owner != null;

		public bool hasHDShadowSlot => Target != null;

		public int hdShadowSlot
		{
			get
			{
				if (Target == null)
				{
					return -1;
				}
				return Target.slot;
			}
		}

		public Settings settings => CurrentSettings;

		public bool hdShadowEnabled => CurrentSettings.enableHDShadow;

		public int rendererCount => Renderers.Length;

		internal Registration(int registrationId, GameObject owner, Settings settings)
		{
			RegistrationId = registrationId;
			Owner = owner;
			Renderers = Array.Empty<Renderer>();
			CurrentSettings = settings;
		}

		public Renderer GetRenderer(int index)
		{
			if ((uint)index >= (uint)Renderers.Length)
			{
				return null;
			}
			return Renderers[index];
		}
	}

	private static readonly Dictionary<int, Registration> s_Registrations = new Dictionary<int, Registration>(8);

	public static Registration Register(GameObject owner)
	{
		return Register(owner, Settings.defaultValue);
	}

	public static Registration Register(GameObject owner, Settings settings)
	{
		if (owner == null)
		{
			return null;
		}
		int instanceID = owner.GetInstanceID();
		if (s_Registrations.TryGetValue(instanceID, out var value))
		{
			if (value.Owner != null)
			{
				return null;
			}
			s_Registrations.Remove(instanceID);
			ReleaseRegistration(value);
		}
		Registration registration = new Registration(instanceID, owner, settings);
		RebuildRenderersAndShadow(registration);
		if (registration.Renderers.Length == 0)
		{
			return null;
		}
		s_Registrations.Add(instanceID, registration);
		ApplyHDShadowSettings(registration);
		return registration;
	}

	public static bool TryGetRegistration(GameObject owner, out Registration registration)
	{
		registration = null;
		if (owner == null || !s_Registrations.TryGetValue(owner.GetInstanceID(), out var value) || value.Owner != owner)
		{
			return false;
		}
		registration = value;
		return true;
	}

	public static void Configure(Registration registration, Settings settings)
	{
		if (IsRegistered(registration))
		{
			bool flag = registration.CurrentSettings.enableHDShadow != settings.enableHDShadow;
			registration.CurrentSettings = settings;
			if (flag || (settings.enableHDShadow && registration.Target == null))
			{
				SynchronizeHDShadowRegistration(registration);
			}
			ApplyHDShadowSettings(registration);
		}
	}

	public static void SetMainLightRotation(Registration registration, Quaternion rotation)
	{
		if (IsRegistered(registration))
		{
			Settings currentSettings = registration.CurrentSettings;
			currentSettings.mainLightRotation = rotation;
			registration.CurrentSettings = currentSettings;
			ApplyHDShadowSettings(registration);
		}
	}

	public static void SetHDShadowEnabled(Registration registration, bool enabled)
	{
		if (IsRegistered(registration))
		{
			Settings currentSettings = registration.CurrentSettings;
			if (currentSettings.enableHDShadow != enabled)
			{
				currentSettings.enableHDShadow = enabled;
				registration.CurrentSettings = currentSettings;
			}
			SynchronizeHDShadowRegistration(registration);
			ApplyHDShadowSettings(registration);
		}
	}

	public static void RefreshRenderers(Registration registration)
	{
		if (IsRegistered(registration))
		{
			if (registration.Target != null)
			{
				HDShadow.UnregisterTarget(registration.Target);
				registration.Target = null;
			}
			RebuildRenderersAndShadow(registration);
			ApplyHDShadowSettings(registration);
		}
	}

	public static void Unregister(Registration registration)
	{
		if (IsRegistered(registration))
		{
			s_Registrations.Remove(registration.RegistrationId);
			ReleaseRegistration(registration);
		}
	}

	internal static void Reset()
	{
		foreach (Registration value in s_Registrations.Values)
		{
			ReleaseRegistration(value);
		}
		s_Registrations.Clear();
	}

	private static bool IsRegistered(Registration registration)
	{
		if (registration != null && registration.Owner != null && s_Registrations.TryGetValue(registration.RegistrationId, out var value))
		{
			return value == registration;
		}
		return false;
	}

	private static void RebuildRenderersAndShadow(Registration registration)
	{
		if (registration.CurrentSettings.enableHDShadow)
		{
			registration.Target = HDShadow.RegisterTarget(registration.RegistrationId, registration.Owner);
		}
		registration.Renderers = ((registration.Target != null) ? registration.Target.renderers : CollectSupportedRenderers(registration.Owner));
		if (registration.Target == null)
		{
			HDShadow.ClearCharacterShadowSlotBits(registration.Renderers);
		}
	}

	private static void SynchronizeHDShadowRegistration(Registration registration)
	{
		if (registration.CurrentSettings.enableHDShadow)
		{
			if (registration.Target == null)
			{
				registration.Target = HDShadow.RegisterTarget(registration.RegistrationId, registration.Owner);
				if (registration.Target != null)
				{
					registration.Renderers = registration.Target.renderers;
				}
			}
		}
		else if (registration.Target != null)
		{
			Renderer[] renderers = registration.Target.renderers;
			HDShadow.UnregisterTarget(registration.Target);
			registration.Target = null;
			registration.Renderers = renderers;
		}
	}

	private static Renderer[] CollectSupportedRenderers(GameObject owner)
	{
		Renderer[] componentsInChildren = owner.GetComponentsInChildren<Renderer>(includeInactive: true);
		int num = 0;
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			if (componentsInChildren[i] is SkinnedMeshRenderer || componentsInChildren[i] is MeshRenderer)
			{
				num++;
			}
		}
		if (num == 0)
		{
			return Array.Empty<Renderer>();
		}
		Renderer[] array = new Renderer[num];
		int num2 = 0;
		foreach (Renderer renderer in componentsInChildren)
		{
			if (renderer is SkinnedMeshRenderer || renderer is MeshRenderer)
			{
				array[num2++] = renderer;
			}
		}
		return array;
	}

	private static void ApplyHDShadowSettings(Registration registration)
	{
		HDShadow.HDTarget target = registration.Target;
		if (target != null)
		{
			target.useCustomLightRotation = true;
			target.mainLightRotation = registration.CurrentSettings.mainLightRotation;
		}
	}

	private static void ReleaseRegistration(Registration registration)
	{
		if (registration.Target != null)
		{
			HDShadow.UnregisterTarget(registration.Target);
		}
		else
		{
			HDShadow.ClearCharacterShadowSlotBits(registration.Renderers);
		}
		registration.Target = null;
		registration.Renderers = Array.Empty<Renderer>();
		registration.Owner = null;
	}
}
