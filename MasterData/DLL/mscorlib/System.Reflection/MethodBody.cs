using System.Runtime.InteropServices;

namespace System.Reflection;

[ComVisible(true)]
public class MethodBody
{
	private ExceptionHandlingClause[] clauses;

	private LocalVariableInfo[] locals;

	private byte[] il;

	private bool init_locals;

	private int sig_token;

	private int max_stack;

	protected MethodBody()
	{
	}

	internal MethodBody(ExceptionHandlingClause[] clauses, LocalVariableInfo[] locals, byte[] il, bool init_locals, int sig_token, int max_stack)
	{
		this.clauses = clauses;
		this.locals = locals;
		this.il = il;
		this.init_locals = init_locals;
		this.sig_token = sig_token;
		this.max_stack = max_stack;
	}
}
