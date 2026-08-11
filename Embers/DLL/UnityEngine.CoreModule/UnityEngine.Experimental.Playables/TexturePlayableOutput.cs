using UnityEngine.Bindings;
using UnityEngine.Playables;
using UnityEngine.Scripting;

namespace UnityEngine.Experimental.Playables;

[RequiredByNativeCode]
[NativeHeader("Runtime/Graphics/RenderTexture.h")]
[NativeHeader("Runtime/Graphics/Director/TexturePlayableOutput.h")]
[NativeHeader("Runtime/Export/Director/TexturePlayableOutput.bindings.h")]
[StaticAccessor(/*Could not decode attribute arguments.*/)]
public struct TexturePlayableOutput : IPlayableOutput
{
	private PlayableOutputHandle m_Handle;

	public PlayableOutputHandle GetHandle()
	{
		return m_Handle;
	}
}
