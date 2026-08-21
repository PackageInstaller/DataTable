namespace Ase.ECS;

public interface IComponent : ILifeCycle, IInit, IAwake, IStart, IUpdate, IFixedUpdate, IPause, IDispose
{
}
