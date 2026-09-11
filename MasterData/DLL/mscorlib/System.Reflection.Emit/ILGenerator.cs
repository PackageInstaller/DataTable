namespace System.Reflection.Emit;

public class ILGenerator
{
	public virtual LocalBuilder DeclareLocal(Type localType)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual Label DefineLabel()
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, byte arg)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, short arg)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, int arg)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, long arg)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, ConstructorInfo con)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, Label label)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, Label[] labels)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, LocalBuilder local)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, FieldInfo field)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, MethodInfo meth)
	{
		throw new PlatformNotSupportedException();
	}

	[CLSCompliant(false)]
	public void Emit(OpCode opcode, sbyte arg)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, string str)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void Emit(OpCode opcode, Type cls)
	{
		throw new PlatformNotSupportedException();
	}

	public virtual void MarkLabel(Label loc)
	{
		throw new PlatformNotSupportedException();
	}
}
