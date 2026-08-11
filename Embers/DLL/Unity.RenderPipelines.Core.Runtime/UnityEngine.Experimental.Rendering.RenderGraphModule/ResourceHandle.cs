namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal struct ResourceHandle
{
	private const uint kValidityMask = 4294901760u;

	private const uint kIndexMask = 65535u;

	private uint m_Value;

	private static uint s_CurrentValidBit = 65536u;

	private static uint s_SharedResourceValidBit = 2147418112u;

	public int index => (int)(m_Value & 0xFFFF);

	public RenderGraphResourceType type { get; private set; }

	public int iType => (int)type;

	internal ResourceHandle(int value, RenderGraphResourceType type, bool shared)
	{
		m_Value = (uint)(value & 0xFFFF) | (shared ? s_SharedResourceValidBit : s_CurrentValidBit);
		this.type = type;
	}

	public static implicit operator int(ResourceHandle handle)
	{
		return handle.index;
	}

	public bool IsValid()
	{
		uint num = m_Value & 0xFFFF0000u;
		if (num != 0)
		{
			if (num != s_CurrentValidBit)
			{
				return num == s_SharedResourceValidBit;
			}
			return true;
		}
		return false;
	}

	public static void NewFrame(int executionIndex)
	{
		uint num = s_CurrentValidBit;
		s_CurrentValidBit = (uint)(((executionIndex >> 16) ^ ((executionIndex & 0xFFFF) * 58546883)) << 16);
		if (s_CurrentValidBit == 0 || s_CurrentValidBit == s_SharedResourceValidBit)
		{
			uint num2;
			for (num2 = 1u; num == num2 << 16; num2++)
			{
			}
			s_CurrentValidBit = num2 << 16;
		}
	}
}
