using System;
using System.ComponentModel;
using GameFramework.Network;

namespace Ase;

public class MessageObject : IMessage, ISupportInitialize, IDisposable
{
	public bool IsFromPool { get; set; }

	public virtual void BeginInit()
	{
	}

	public virtual void EndInit()
	{
	}

	public virtual void Dispose()
	{
	}
}
