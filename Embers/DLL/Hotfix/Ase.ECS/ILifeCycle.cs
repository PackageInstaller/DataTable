namespace Ase.ECS;

public interface ILifeCycle : IInit, IAwake, IStart, IUpdate, IFixedUpdate, IPause, IDispose
{
}
