using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Experimental.Playables;

[NativeHeader("Runtime/Graphics/RenderTexture.h")]
[StaticAccessor("TexturePlayableOutputBindings", StaticAccessorType.DoubleColon)]
[NativeHeader("Runtime/Export/Director/TexturePlayableOutput.bindings.h")]
[RequiredByNativeCode]
[NativeHeader("Runtime/Graphics/Director/TexturePlayableOutput.h")]
public struct TexturePlayableOutput : IPlayableOutput
{
	private PlayableOutputHandle m_Handle;

	public PlayableOutputHandle GetHandle()
	{
		return m_Handle;
	}
}
