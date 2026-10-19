namespace ACT.Model;

public interface IClientModuleModelNtfCall
{
	void SetModuleState(ClientModuleModel.ClientModuleEnum module, int id, bool state);
}
