namespace FlowCanvas.Nodes;

public enum CantBreakReason
{
	common = 1,
	flowNode = 2,
	skill1 = 4,
	skill2 = 8,
	skill3 = 0x10,
	skill4 = 0x20,
	skill5 = 0x40,
	skill6 = 0x80,
	skill7 = 0x100,
	skill8 = 0x200,
	skill9 = 0x400,
	attack1 = 0x800,
	attack2 = 0x1000,
	attack3 = 0x2000,
	attack4 = 0x4000,
	attack5 = 0x8000,
	attack6 = 0x10000,
	attack7 = 0x20000,
	attack8 = 0x40000,
	attack9 = 0x80000,
	other1 = 0x100000
}
