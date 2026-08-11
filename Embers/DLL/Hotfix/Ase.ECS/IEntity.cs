namespace Ase.ECS;

public interface IEntity : ILifeCycle, IInit, IAwake, IStart, IUpdate, IFixedUpdate, IPause, IDispose
{
}
