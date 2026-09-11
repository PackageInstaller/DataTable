namespace System.ComponentModel.Design;

public interface IReferenceService
{
	object GetReference(string name);

	string GetName(object reference);

	object[] GetReferences(Type baseType);
}
