using System.Collections.Generic;

namespace BilliardGame.Spell;

public interface IRuntimeAIConfig
{
	string Name { get; }

	List<BNode> Nodes { get; set; }
}
