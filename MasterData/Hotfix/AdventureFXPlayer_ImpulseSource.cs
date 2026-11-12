using Cinemachine;

public class AdventureFXPlayer_ImpulseSource : AdventureFXPlayer_Component
{
	private const int kPlayerChannel = 2;

	internal CinemachineImpulseSource[] impulseSources;

	public override void Play()
	{
		for (int i = 0; i < impulseSources.Length; i++)
		{
			CinemachineImpulseSource obj = impulseSources[i];
			obj.m_ImpulseDefinition.m_ImpulseChannel = 2;
			obj.GenerateImpulse();
		}
	}
}
