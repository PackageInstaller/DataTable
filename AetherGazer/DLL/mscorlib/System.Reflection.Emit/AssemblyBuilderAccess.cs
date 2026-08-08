using System.Runtime.InteropServices;

namespace System.Reflection.Emit;

[Serializable]
[ComVisible(true)]
[Flags]
public enum AssemblyBuilderAccess
{
	Run = 1,
	Save = 2,
	RunAndSave = Run | Save,
	ReflectionOnly = 6,
	RunAndCollect = 9
}
