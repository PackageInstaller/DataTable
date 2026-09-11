using System;
using System.Runtime.CompilerServices;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[无常]得到当前时辰(渲染)", 0)]
[Category("Render/角色定制/无常")]
[Description("得到当前的时辰，尽可用于表现，无法正确同步，战斗回放时会有不一致是正常的")]
public class CustomFunction1054Render_1 : PureFunctionNode<int>
{
	public override int Invoke()
	{
		//IL_000d: Field data (rva=0x490) could not be found in any section!
		//IL_000d: Field data (rva=0x490) could not be found in any section!
		int[] array = new int[24];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		int hour = DateTime.Now.Hour;
		return array[hour];
	}
}
