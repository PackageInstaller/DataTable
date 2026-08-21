using System.Collections.Generic;
using GameFramework;

namespace Ase;

public interface IBuffOperation : IReference
{
	void Create(BuffOperationType effectType, List<string> paramList);

	void ResetParams(params object[] args);

	BuffDataBase GetData();

	void Init(Buff buff);

	void Execute();

	void NotExecute();

	void Update(float deltaTime);

	void UpdateLayerChanged(int deltaLayer);

	void Dispose();
}
