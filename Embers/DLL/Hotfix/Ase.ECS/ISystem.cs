namespace Ase.ECS;

public interface ISystem : ILifeCycle, IInit, IAwake, IStart, IUpdate, IFixedUpdate, IPause, IDispose, IReset
{
}
