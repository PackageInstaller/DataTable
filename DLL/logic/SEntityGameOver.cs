using Entitas;
using Entitas.CodeGeneration.Attributes;

[Sim]
[Unique]
public class SEntityGameOver : IComponent
{
	public GameOverState state;

	public int countdown;

	public int timeScale;

	public E_BattleResult isVectory;
}
