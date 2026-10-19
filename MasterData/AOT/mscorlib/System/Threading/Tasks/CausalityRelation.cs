namespace System.Threading.Tasks;

internal enum CausalityRelation
{
	AssignDelegate,
	Join,
	Choice,
	Cancel,
	Error
}
