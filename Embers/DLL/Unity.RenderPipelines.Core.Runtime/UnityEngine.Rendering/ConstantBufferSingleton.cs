namespace UnityEngine.Rendering;

internal class ConstantBufferSingleton<CBType> : ConstantBuffer<CBType> where CBType : struct
{
	private static ConstantBufferSingleton<CBType> s_Instance;

	internal static ConstantBufferSingleton<CBType> instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new ConstantBufferSingleton<CBType>();
				ConstantBuffer.Register(s_Instance);
			}
			return s_Instance;
		}
		set
		{
			s_Instance = value;
		}
	}

	public override void Release()
	{
		base.Release();
		s_Instance = null;
	}
}
