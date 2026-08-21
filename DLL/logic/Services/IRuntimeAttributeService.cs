namespace Services;

public interface IRuntimeAttributeService
{
	bool TryGetAttribute(int id, out EntityAttribute attribute);

	int CreateAttribute(int entityID, out EntityAttribute entityAttribute);
}
