.version	5.4

.format	0
.instruction_size	4
.integer_format	8
.float_format	8
.endianness	LITTLE

.function	main

.source	"@Assets\\Lua\\GameScript\\UI\\Trinket\\Panel\\TrinketFilterPanel.lua"
.linedefined	0
.lastlinedefined	0
.numparams	0
.is_vararg	1
.maxstacksize	11

.local	"TrinketFilterPanel"	6	120
.local	"Super"	6	120
.local	"TrinketFilterState"	12	120
.local	"TagGroup_Attrs"	13	120
.local	"TagGroup_Title"	14	120
.local	"TagGroup_Part"	15	120
.local	"TagGroup_Suit"	16	120
.local	"TableCellType"	26	120
.local	"CellsGameObject"	76	120

.upvalue	"_ENV"	0	true

.constant	k0	"System"
.constant	k1	"NewClass"
.constant	k2	"TrinketFilterPanel"
.constant	k3	"UIBasePanel"
.constant	k4	"uiResCls"
.constant	k5	L"UI_Alchemy_Popup_ResolveMaterials_Sift2Resource"
.constant	k6	"CommonDefine"
.constant	k7	"TrinketFilterState"
.constant	k8	"SuitTitle"
.constant	k9	1
.constant	k10	"Suit"
.constant	k11	2
.constant	k12	"PartTitle"
.constant	k13	3
.constant	k14	"Part"
.constant	k15	4
.constant	k16	"MainAttrTitle"
.constant	k17	5
.constant	k18	"MainAttr"
.constant	k19	6
.constant	k20	"SubAttrTitle"
.constant	k21	7
.constant	k22	"SubAttr"
.constant	k23	8
.constant	k24	"tag"
.constant	k25	"go"
.constant	k26	"Group_Sift_Title1"
.constant	k27	"UI_Alchemy_Popup_ResolveMaterials_Iten1"
.constant	k28	"Group_Btn"
.constant	k29	"Group_Attrs"
.constant	k30	"ctor"
.constant	k31	"OnBind"
.constant	k32	"AfterSetRenderTrue"
.constant	k33	"BindTableview"
.constant	k34	"RefreshFiltersView"
.constant	k35	"_DequeCellByCellCfg"
.constant	k36	"_FillSuitTitleCell"
.constant	k37	"_FillSuitCell"
.constant	k38	"_FillPartTitleCell"
.constant	k39	"_FillPartCell"
.constant	k40	"_FillMainAttrTitleCell"
.constant	k41	"_FillMainAttrCell"
.constant	k42	"_FillSubAttrTitleCell"
.constant	k43	"_FillSubAttrCell"
.constant	k44	"_FillAttrItem"
.constant	k45	"GenerateViewData"
.constant	k46	"_KeysToArray"
.constant	k47	"_SubAttrKeysToArray"
.constant	k48	"IsFilterChanged"
.constant	k49	"OnClickClose"
.constant	k50	"Close"

.line	0	varargprep     0
.line	0	gettabup      r0    u0    k0 ; k0 = "System"
.line	0	getfield      r0    r0    k1 ; k1 = "NewClass"
.line	0	loadk         r1    k2 ; k2 = "TrinketFilterPanel"
.line	0	gettabup      r2    u0    k3 ; k3 = "UIBasePanel"
.line	0	call          r0     3     3
.line	1	getupval      r2    u0
.line	0	loadk         r3    k5 ; k5 = L"UI_Alchemy_Popup_Res" (truncated)
.line	0	gettable      r2    r2    r3
.line	0	setfield      r0    k4    r2 ; k4 = "uiResCls"
.line	1	gettabup      r2    u0    k6 ; k6 = "CommonDefine"
.line	0	getfield      r2    r2    k7 ; k7 = "TrinketFilterState"
.line	1	loadi         r3   100
.line	1	loadi         r4   101
.line	1	loadi         r5   102
.line	1	loadi         r6   103
.line	2	newtable      r7     4     0     1
.line	0	extraarg       0
.line	2	setfield      r7    k8    k9  k= 1 ; k9 = 1
.line	1	setfield      r7   k10   k11  k= 1 ; k11 = 2
.line	1	setfield      r7   k12   k13  k= 1 ; k13 = 3
.line	1	setfield      r7   k14   k15  k= 1 ; k15 = 4
.line	1	setfield      r7   k16   k17  k= 1 ; k17 = 5
.line	1	setfield      r7   k18   k19  k= 1 ; k19 = 6
.line	1	setfield      r7   k20   k21  k= 1 ; k21 = 7
.line	1	setfield      r7   k22   k23  k= 1 ; k23 = 8
.line	3	newtable      r8     4     0     1
.line	0	extraarg       0
.line	2	getfield      r9    r7    k8 ; k8 = "SuitTitle"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	setfield     r10   k24    r4 ; k24 = "tag"
.line	0	setfield     r10   k25   k26  k= 1 ; k26 = "Group_Sift_Title1"
.line	0	settable      r8    r9   r10
.line	1	getfield      r9    r7   k10 ; k10 = "Suit"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	setfield     r10   k24    r6 ; k24 = "tag"
.line	0	setfield     r10   k25   k27  k= 1 ; k27 = "UI_Alchemy_Popup_Res" (truncated)
.line	0	settable      r8    r9   r10
.line	1	getfield      r9    r7   k12 ; k12 = "PartTitle"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	setfield     r10   k24    r4 ; k24 = "tag"
.line	0	setfield     r10   k25   k26  k= 1 ; k26 = "Group_Sift_Title1"
.line	0	settable      r8    r9   r10
.line	1	getfield      r9    r7   k14 ; k14 = "Part"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	setfield     r10   k24    r5 ; k24 = "tag"
.line	0	setfield     r10   k25   k28  k= 1 ; k28 = "Group_Btn"
.line	0	settable      r8    r9   r10
.line	1	getfield      r9    r7   k16 ; k16 = "MainAttrTitle"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	setfield     r10   k24    r4 ; k24 = "tag"
.line	0	setfield     r10   k25   k26  k= 1 ; k26 = "Group_Sift_Title1"
.line	0	settable      r8    r9   r10
.line	1	getfield      r9    r7   k18 ; k18 = "MainAttr"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	setfield     r10   k24    r3 ; k24 = "tag"
.line	0	setfield     r10   k25   k29  k= 1 ; k29 = "Group_Attrs"
.line	0	settable      r8    r9   r10
.line	1	getfield      r9    r7   k20 ; k20 = "SubAttrTitle"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	setfield     r10   k24    r4 ; k24 = "tag"
.line	0	setfield     r10   k25   k26  k= 1 ; k26 = "Group_Sift_Title1"
.line	0	settable      r8    r9   r10
.line	1	getfield      r9    r7   k22 ; k22 = "SubAttr"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	setfield     r10   k24    r3 ; k24 = "tag"
.line	0	setfield     r10   k25   k29  k= 1 ; k29 = "Group_Attrs"
.line	0	settable      r8    r9   r10
.line	19	closure       r9    f0
.line	240	setfield      r0   k30    r9 ; k30 = "ctor"
.line	31	closure       r9    f1
.line	243	setfield      r0   k31    r9 ; k31 = "OnBind"
.line	19	closure       r9    f2
.line	252	setfield      r0   k32    r9 ; k32 = "AfterSetRenderTrue"
.line	39	closure       r9    f3
.line	223	setfield      r0   k33    r9 ; k33 = "BindTableview"
.line	38	closure       r9    f4
.line	253	setfield      r0   k34    r9 ; k34 = "RefreshFiltersView"
.line	15	closure       r9    f5
.line	246	setfield      r0   k35    r9 ; k35 = "_DequeCellByCellCfg"
.line	23	closure       r9    f6
.line	245	setfield      r0   k36    r9 ; k36 = "_FillSuitTitleCell"
.line	22	closure       r9    f7
.line	247	setfield      r0   k37    r9 ; k37 = "_FillSuitCell"
.line	15	closure       r9    f8
.line	252	setfield      r0   k38    r9 ; k38 = "_FillPartTitleCell"
.line	30	closure       r9    f9
.line	232	setfield      r0   k39    r9 ; k39 = "_FillPartCell"
.line	37	closure       r9   f10
.line	245	setfield      r0   k40    r9 ; k40 = "_FillMainAttrTitleCe" (truncated)
.line	27	closure       r9   f11
.line	242	setfield      r0   k41    r9 ; k41 = "_FillMainAttrCell"
.line	27	closure       r9   f12
.line	245	setfield      r0   k42    r9 ; k42 = "_FillSubAttrTitleCel" (truncated)
.line	31	closure       r9   f13
.line	238	setfield      r0   k43    r9 ; k43 = "_FillSubAttrCell"
.line	25	closure       r9   f14
.line	251	setfield      r0   k44    r9 ; k44 = "_FillAttrItem"
.line	37	closure       r9   f15
.line	226	setfield      r0   k45    r9 ; k45 = "GenerateViewData"
.line	40	closure       r9   f16
.line	248	setfield      r0   k46    r9 ; k46 = "_KeysToArray"
.line	18	closure       r9   f17
.line	248	setfield      r0   k47    r9 ; k47 = "_SubAttrKeysToArray"
.line	35	closure       r9   f18
.line	231	setfield      r0   k48    r9 ; k48 = "IsFilterChanged"
.line	29	closure       r9   f19
.line	254	setfield      r0   k49    r9 ; k49 = "OnClickClose"
.line	9	closure       r9   f20
.line	251	setfield      r0   k50    r9 ; k50 = "Close"
.line	8	return        r0     2     1     1
.line	0	return        r9     1     1     1

.function	main/f0

.source	null
.linedefined	33
.lastlinedefined	49
.numparams	4
.is_vararg	0
.maxstacksize	6

.local	"self"	0	40
.local	"awakerTrinkModel"	0	40
.local	"position"	0	40
.local	"closeFunc"	0	40

.upvalue	"Super"	1	true
.upvalue	"_ENV"	0	false

.constant	k0	"ctor"
.constant	k1	"awakerTrinkModel"
.constant	k2	"childrenBinders"
.constant	k3	"filterSuitsMap"
.constant	k4	"filterParts"
.constant	k5	"filterMainAttrs"
.constant	k6	"filterSubAttrs"
.constant	k7	"position"
.constant	k8	"selectPos"
.constant	k9	"closeFunc"
.constant	k10	"saveSuitsStatus"
.constant	k11	"table"
.constant	k12	"clone"
.constant	k13	"savePartsStatus"
.constant	k14	"saveMainAttrsStatus"
.constant	k15	"saveSubAttrsStatus"

.line	1	gettabup      r4    u0    k0 ; k0 = "ctor"
.line	0	move          r5    r0
.line	0	call          r4     2     1
.line	1	setfield      r0    k1    r1 ; k1 = "awakerTrinkModel"
.line	1	newtable      r4     0     0     1
.line	0	extraarg       0
.line	0	setfield      r0    k2    r4 ; k2 = "childrenBinders"
.line	1	getfield      r4    r1    k3 ; k3 = "filterSuitsMap"
.line	0	setfield      r0    k3    r4 ; k3 = "filterSuitsMap"
.line	1	getfield      r4    r1    k4 ; k4 = "filterParts"
.line	0	setfield      r0    k4    r4 ; k4 = "filterParts"
.line	1	getfield      r4    r1    k5 ; k5 = "filterMainAttrs"
.line	0	setfield      r0    k5    r4 ; k5 = "filterMainAttrs"
.line	1	getfield      r4    r1    k6 ; k6 = "filterSubAttrs"
.line	0	setfield      r0    k6    r4 ; k6 = "filterSubAttrs"
.line	1	setfield      r0    k7    r2 ; k7 = "position"
.line	1	getfield      r4    r1    k8 ; k8 = "selectPos"
.line	0	setfield      r0    k8    r4 ; k8 = "selectPos"
.line	1	setfield      r0    k9    r3 ; k9 = "closeFunc"
.line	2	gettabup      r4    u1   k11 ; k11 = "table"
.line	0	getfield      r4    r4   k12 ; k12 = "clone"
.line	0	getfield      r5    r0    k3 ; k3 = "filterSuitsMap"
.line	0	call          r4     2     2
.line	0	setfield      r0   k10    r4 ; k10 = "saveSuitsStatus"
.line	1	gettabup      r4    u1   k11 ; k11 = "table"
.line	0	getfield      r4    r4   k12 ; k12 = "clone"
.line	0	getfield      r5    r0    k4 ; k4 = "filterParts"
.line	0	call          r4     2     2
.line	0	setfield      r0   k13    r4 ; k13 = "savePartsStatus"
.line	1	gettabup      r4    u1   k11 ; k11 = "table"
.line	0	getfield      r4    r4   k12 ; k12 = "clone"
.line	0	getfield      r5    r0    k5 ; k5 = "filterMainAttrs"
.line	0	call          r4     2     2
.line	0	setfield      r0   k14    r4 ; k14 = "saveMainAttrsStatus"
.line	1	gettabup      r4    u1   k11 ; k11 = "table"
.line	0	getfield      r4    r4   k12 ; k12 = "clone"
.line	0	getfield      r5    r0    k6 ; k6 = "filterSubAttrs"
.line	0	call          r4     2     2
.line	0	setfield      r0   k15    r4 ; k15 = "saveSubAttrsStatus"
.line	1	return0       r4     1     0     0

.function	main/f1

.source	null
.linedefined	51
.lastlinedefined	64
.numparams	2
.is_vararg	0
.maxstacksize	6

.local	"self"	0	24
.local	"binder"	0	24

.constant	k0	"binder"
.constant	k1	"BindTableview"
.constant	k2	"RefreshFiltersView"
.constant	k3	"BindButtonClick"
.constant	k4	"ui"
.constant	k5	"Btn_Reset"
.constant	k6	"Btn_Confirm"
.constant	k7	"uiNode"
.constant	k8	"transform"
.constant	k9	"position"

.line	1	setfield      r0    k0    r1 ; k0 = "binder"
.line	1	self          r2    r0    k1  k= 1 ; k1 = "BindTableview"
.line	0	move          r4    r1
.line	0	call          r2     3     1
.line	1	self          r2    r0    k2  k= 1 ; k2 = "RefreshFiltersView"
.line	0	call          r2     2     1
.line	1	getfield      r2    r0    k0 ; k0 = "binder"
.line	0	self          r2    r2    k3  k= 1 ; k3 = "BindButtonClick"
.line	0	getfield      r4    r0    k4 ; k4 = "ui"
.line	0	getfield      r4    r4    k5 ; k5 = "Btn_Reset"
.line	3	closure       r5    f0
.line	253	call          r2     4     1
.line	4	getfield      r2    r0    k0 ; k0 = "binder"
.line	0	self          r2    r2    k3  k= 1 ; k3 = "BindButtonClick"
.line	0	getfield      r4    r0    k4 ; k4 = "ui"
.line	0	getfield      r4    r4    k6 ; k6 = "Btn_Confirm"
.line	3	closure       r5    f1
.line	253	call          r2     4     1
.line	4	getfield      r2    r0    k4 ; k4 = "ui"
.line	0	getfield      r2    r2    k7 ; k7 = "uiNode"
.line	0	getfield      r2    r2    k8 ; k8 = "transform"
.line	0	getfield      r3    r0    k9 ; k9 = "position"
.line	0	setfield      r2    k9    r3 ; k9 = "position"
.line	1	return        r2     1     0     1

.function	main/f1/f0

.source	null
.linedefined	55
.lastlinedefined	58
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"self"	0	true

.constant	k0	"awakerTrinkModel"
.constant	k1	"ResetFilters"
.constant	k2	"RefreshFiltersView"

.line	1	gettabup      r0    u0    k0 ; k0 = "awakerTrinkModel"
.line	0	self          r0    r0    k1  k= 1 ; k1 = "ResetFilters"
.line	0	call          r0     2     1
.line	1	getupval      r0    u0
.line	0	self          r0    r0    k2  k= 1 ; k2 = "RefreshFiltersView"
.line	0	call          r0     2     1
.line	1	return0       r0     1     0     0

.function	main/f1/f1

.source	null
.linedefined	59
.lastlinedefined	62
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"self"	0	true

.constant	k0	"awakerTrinkModel"
.constant	k1	"UpdateTrinketShowList"
.constant	k2	"Close"

.line	1	gettabup      r0    u0    k0 ; k0 = "awakerTrinkModel"
.line	0	self          r0    r0    k1  k= 1 ; k1 = "UpdateTrinketShowLis" (truncated)
.line	0	call          r0     2     1
.line	1	getupval      r0    u0
.line	0	self          r0    r0    k2  k= 1 ; k2 = "Close"
.line	0	call          r0     2     1
.line	1	return0       r0     1     0     0

.function	main/f2

.source	null
.linedefined	66
.lastlinedefined	70
.numparams	1
.is_vararg	0
.maxstacksize	3

.local	"self"	0	13

.constant	k0	"ui"
.constant	k1	"uiNode"
.constant	k2	"transform"
.constant	k3	"position"

.line	1	getfield      r1    r0    k0 ; k0 = "ui"
.line	0	test          r1     0
.line	0	jmp          l13
.line	0	getfield      r1    r0    k0 ; k0 = "ui"
.line	0	getfield      r1    r1    k1 ; k1 = "uiNode"
.line	0	test          r1     0
.line	0	jmp          l13
.line	1	getfield      r1    r0    k0 ; k0 = "ui"
.line	0	getfield      r1    r1    k1 ; k1 = "uiNode"
.line	0	getfield      r1    r1    k2 ; k2 = "transform"
.line	0	getfield      r2    r0    k3 ; k3 = "position"
.line	0	setfield      r1    k3    r2 ; k3 = "position"
.label	l13
.line	2	return0       r1     1     0     0

.function	main/f3

.source	null
.linedefined	72
.lastlinedefined	105
.numparams	2
.is_vararg	0
.maxstacksize	7

.local	"self"	0	25
.local	"binder"	0	25
.local	"tableCellSize"	6	25

.upvalue	"_ENV"	0	false
.upvalue	"TableCellType"	7	true

.constant	k0	"CS"
.constant	k1	"UnityEngine"
.constant	k2	"Vector2"
.constant	k3	"tableview"
.constant	k4	"ui"
.constant	k5	"ScrollView_List"
.constant	k6	"GetComponent"
.constant	k7	"typeof"
.constant	k8	"UITableview"
.constant	k9	"tableCellAtIndex"
.constant	k10	"numberCellsInTableview"
.constant	k11	"tableCellSizeForIndex"

.line	1	gettabup      r2    u0    k0 ; k0 = "CS"
.line	0	getfield      r2    r2    k1 ; k1 = "UnityEngine"
.line	0	getfield      r2    r2    k2 ; k2 = "Vector2"
.line	0	loadi         r3     0
.line	0	loadi         r4     0
.line	0	call          r2     3     2
.line	1	getfield      r3    r0    k4 ; k4 = "ui"
.line	0	getfield      r3    r3    k5 ; k5 = "ScrollView_List"
.line	0	self          r3    r3    k6  k= 1 ; k6 = "GetComponent"
.line	0	gettabup      r5    u0    k7 ; k7 = "typeof"
.line	0	gettabup      r6    u0    k0 ; k0 = "CS"
.line	0	getfield      r6    r6    k8 ; k8 = "UITableview"
.line	0	call          r5     2     0
.line	0	call          r3     0     2
.line	0	setfield      r0    k3    r3 ; k3 = "tableview"
.line	1	getfield      r3    r0    k3 ; k3 = "tableview"
.line	21	closure       r4    f0
.line	0	setfield      r3    k9    r4 ; k9 = "tableCellAtIndex"
.line	1	getfield      r3    r0    k3 ; k3 = "tableview"
.line	2	closure       r4    f1
.line	0	setfield      r3   k10    r4 ; k10 = "numberCellsInTablevi" (truncated)
.line	1	getfield      r3    r0    k3 ; k3 = "tableview"
.line	4	closure       r4    f2
.line	0	setfield      r3   k11    r4 ; k11 = "tableCellSizeForInde" (truncated)
.line	1	return        r3     1     0     1

.function	main/f3/f0

.source	null
.linedefined	75
.lastlinedefined	96
.numparams	2
.is_vararg	0
.maxstacksize	10

.local	"view"	0	98
.local	"index"	0	98
.local	"cellCfg"	4	98
.local	"cell"	9	98
.local	"childBinder"	9	98

.upvalue	"self"	0	true
.upvalue	"TableCellType"	1	false

.constant	k0	"filterViewsData"
.constant	k1	"_DequeCellByCellCfg"
.constant	k2	"tableCellType"
.constant	k3	"SuitTitle"
.constant	k4	"_FillSuitTitleCell"
.constant	k5	"Suit"
.constant	k6	"_FillSuitCell"
.constant	k7	"PartTitle"
.constant	k8	"_FillPartTitleCell"
.constant	k9	"Part"
.constant	k10	"_FillPartCell"
.constant	k11	"MainAttrTitle"
.constant	k12	"_FillMainAttrTitleCell"
.constant	k13	"MainAttr"
.constant	k14	"_FillMainAttrCell"
.constant	k15	"SubAttrTitle"
.constant	k16	"_FillSubAttrTitleCell"
.constant	k17	"SubAttr"
.constant	k18	"_FillSubAttrCell"

.line	1	gettabup      r2    u0    k0 ; k0 = "filterViewsData"
.line	0	addi          r3    r1     1
.line	0	mmbini        r1     1     6     0
.line	0	gettable      r2    r2    r3
.line	1	getupval      r3    u0
.line	0	self          r3    r3    k1  k= 1 ; k1 = "_DequeCellByCellCfg"
.line	0	move          r5    r0
.line	0	move          r6    r2
.line	0	call          r3     4     3
.line	1	getfield      r5    r2    k2 ; k2 = "tableCellType"
.line	0	gettabup      r6    u1    k3 ; k3 = "SuitTitle"
.line	0	eq            r5    r6     0
.line	0	jmp          l21
.line	1	getupval      r5    u0
.line	0	self          r5    r5    k4  k= 1 ; k4 = "_FillSuitTitleCell"
.line	0	move          r7    r3
.line	0	move          r8    r4
.line	0	move          r9    r2
.line	0	call          r5     5     1
.line	0	jmp          l97
.label	l21
.line	1	getfield      r5    r2    k2 ; k2 = "tableCellType"
.line	0	gettabup      r6    u1    k5 ; k5 = "Suit"
.line	0	eq            r5    r6     0
.line	0	jmp          l32
.line	1	getupval      r5    u0
.line	0	self          r5    r5    k6  k= 1 ; k6 = "_FillSuitCell"
.line	0	move          r7    r3
.line	0	move          r8    r4
.line	0	move          r9    r2
.line	0	call          r5     5     1
.line	0	jmp          l97
.label	l32
.line	1	getfield      r5    r2    k2 ; k2 = "tableCellType"
.line	0	gettabup      r6    u1    k7 ; k7 = "PartTitle"
.line	0	eq            r5    r6     0
.line	0	jmp          l43
.line	1	getupval      r5    u0
.line	0	self          r5    r5    k8  k= 1 ; k8 = "_FillPartTitleCell"
.line	0	move          r7    r3
.line	0	move          r8    r4
.line	0	move          r9    r2
.line	0	call          r5     5     1
.line	0	jmp          l97
.label	l43
.line	1	getfield      r5    r2    k2 ; k2 = "tableCellType"
.line	0	gettabup      r6    u1    k9 ; k9 = "Part"
.line	0	eq            r5    r6     0
.line	0	jmp          l54
.line	1	getupval      r5    u0
.line	0	self          r5    r5   k10  k= 1 ; k10 = "_FillPartCell"
.line	0	move          r7    r3
.line	0	move          r8    r4
.line	0	move          r9    r2
.line	0	call          r5     5     1
.line	0	jmp          l97
.label	l54
.line	1	getfield      r5    r2    k2 ; k2 = "tableCellType"
.line	0	gettabup      r6    u1   k11 ; k11 = "MainAttrTitle"
.line	0	eq            r5    r6     0
.line	0	jmp          l65
.line	1	getupval      r5    u0
.line	0	self          r5    r5   k12  k= 1 ; k12 = "_FillMainAttrTitleCe" (truncated)
.line	0	move          r7    r3
.line	0	move          r8    r4
.line	0	move          r9    r2
.line	0	call          r5     5     1
.line	0	jmp          l97
.label	l65
.line	1	getfield      r5    r2    k2 ; k2 = "tableCellType"
.line	0	gettabup      r6    u1   k13 ; k13 = "MainAttr"
.line	0	eq            r5    r6     0
.line	0	jmp          l76
.line	1	getupval      r5    u0
.line	0	self          r5    r5   k14  k= 1 ; k14 = "_FillMainAttrCell"
.line	0	move          r7    r3
.line	0	move          r8    r4
.line	0	move          r9    r2
.line	0	call          r5     5     1
.line	0	jmp          l97
.label	l76
.line	1	getfield      r5    r2    k2 ; k2 = "tableCellType"
.line	0	gettabup      r6    u1   k15 ; k15 = "SubAttrTitle"
.line	0	eq            r5    r6     0
.line	0	jmp          l87
.line	1	getupval      r5    u0
.line	0	self          r5    r5   k16  k= 1 ; k16 = "_FillSubAttrTitleCel" (truncated)
.line	0	move          r7    r3
.line	0	move          r8    r4
.line	0	move          r9    r2
.line	0	call          r5     5     1
.line	0	jmp          l97
.label	l87
.line	1	getfield      r5    r2    k2 ; k2 = "tableCellType"
.line	0	gettabup      r6    u1   k17 ; k17 = "SubAttr"
.line	0	eq            r5    r6     0
.line	0	jmp          l97
.line	1	getupval      r5    u0
.line	0	self          r5    r5   k18  k= 1 ; k18 = "_FillSubAttrCell"
.line	0	move          r7    r3
.line	0	move          r8    r4
.line	0	move          r9    r2
.line	0	call          r5     5     1
.label	l97
.line	2	return1       r3     2     0     0
.line	1	return0       r5     1     0     0

.function	main/f3/f1

.source	null
.linedefined	97
.lastlinedefined	99
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"self"	0	true

.constant	k0	"filterViewsData"

.line	1	gettabup      r0    u0    k0 ; k0 = "filterViewsData"
.line	0	len           r0    r0
.line	0	return1       r0     2     0     0
.line	1	return0       r0     1     0     0

.function	main/f3/f2

.source	null
.linedefined	100
.lastlinedefined	104
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"tableCellSize"	2	true

.constant	k0	"x"
.constant	k1	810
.constant	k2	"y"
.constant	k3	62

.line	1	settabup      u0    k0    k1  k= 1 ; k1 = 810
.line	1	settabup      u0    k2    k3  k= 1 ; k3 = 62
.line	1	getupval      r0    u0
.line	0	return1       r0     2     0     0
.line	1	return0       r0     1     0     0

.function	main/f4

.source	null
.linedefined	107
.lastlinedefined	110
.numparams	1
.is_vararg	0
.maxstacksize	3

.local	"self"	0	6

.constant	k0	"GenerateViewData"
.constant	k1	"tableview"
.constant	k2	"ReloadData"

.line	1	self          r1    r0    k0  k= 1 ; k0 = "GenerateViewData"
.line	0	call          r1     2     1
.line	1	getfield      r1    r0    k1 ; k1 = "tableview"
.line	0	self          r1    r1    k2  k= 1 ; k2 = "ReloadData"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0

.function	main/f5

.source	null
.linedefined	112
.lastlinedefined	122
.numparams	3
.is_vararg	0
.maxstacksize	9

.local	"self"	0	34
.local	"view"	0	34
.local	"cellCfg"	0	34
.local	"cellGoCfg"	3	34
.local	"cell"	6	34

.upvalue	"CellsGameObject"	8	true

.constant	k0	"tableCellType"
.constant	k1	"DequeueCellByTag"
.constant	k2	"tag"
.constant	k3	"AddChild"
.constant	k4	"ui"
.constant	k5	"go"
.constant	k6	"childrenBinders"
.constant	k7	"binder"
.constant	k8	"createChild"
.constant	k9	"clearChildren"

.line	1	getfield      r4    r2    k0 ; k0 = "tableCellType"
.line	0	getupval      r3    u0
.line	0	gettable      r3    r3    r4
.line	1	self          r4    r1    k1  k= 1 ; k1 = "DequeueCellByTag"
.line	0	getfield      r6    r3    k2 ; k2 = "tag"
.line	0	call          r4     3     2
.line	1	test          r4     1
.line	0	jmp          l17
.line	1	self          r5    r1    k3  k= 1 ; k3 = "AddChild"
.line	0	getfield      r7    r0    k4 ; k4 = "ui"
.line	0	getfield      r8    r3    k5 ; k5 = "go"
.line	0	gettable      r7    r7    r8
.line	0	call          r5     3     2
.line	0	move          r4    r5
.line	1	getfield      r5    r3    k2 ; k2 = "tag"
.line	0	setfield      r4    k2    r5 ; k2 = "tag"
.label	l17
.line	2	getfield      r5    r0    k6 ; k6 = "childrenBinders"
.line	0	getfield      r6    r0    k6 ; k6 = "childrenBinders"
.line	0	gettable      r6    r6    r4
.line	0	test          r6     1
.line	0	jmp          l25
.line	0	getfield      r6    r0    k7 ; k7 = "binder"
.line	0	self          r6    r6    k8  k= 1 ; k8 = "createChild"
.line	0	call          r6     2     2
.label	l25
.line	0	settable      r5    r4    r6
.line	1	getfield      r5    r0    k6 ; k6 = "childrenBinders"
.line	0	gettable      r5    r5    r4
.line	0	self          r5    r5    k9  k= 1 ; k9 = "clearChildren"
.line	0	call          r5     2     1
.line	1	move          r5    r4
.line	0	getfield      r6    r0    k6 ; k6 = "childrenBinders"
.line	0	gettable      r6    r6    r4
.line	0	return        r5     3     0     0
.line	1	return0       r5     1     0     0

.function	main/f6

.source	null
.linedefined	124
.lastlinedefined	135
.numparams	4
.is_vararg	0
.maxstacksize	10

.local	"self"	0	21
.local	"cell"	0	21
.local	"binder"	0	21
.local	"cellCfg"	0	21
.local	"uiRes"	5	21

.upvalue	"_ENV"	0	false

.constant	k0	L"UI_Alchemy_Popup_ResolveMaterials_SiftTitleResource"
.constant	k1	"gameObject"
.constant	k2	"SetText"
.constant	k3	"Text_SiftTitle"
.constant	k4	"LT"
.constant	k5	"Text"
.constant	k6	"TrinketFilterSuitTitle"
.constant	k7	"SetActive"
.constant	k8	"UI_Common_Btn_Type_1"
.constant	k9	"BindZ1Button"

.line	1	getupval      r4    u0
.line	0	loadk         r5    k0 ; k0 = L"UI_Alchemy_Popup_Res" (truncated)
.line	0	gettable      r4    r4    r5
.line	0	getfield      r5    r1    k1 ; k1 = "gameObject"
.line	0	call          r4     2     2
.line	1	self          r5    r2    k2  k= 1 ; k2 = "SetText"
.line	0	getfield      r7    r4    k3 ; k3 = "Text_SiftTitle"
.line	0	gettabup      r8    u0    k4 ; k4 = "LT"
.line	0	getfield      r8    r8    k5 ; k5 = "Text"
.line	0	loadk         r9    k6 ; k6 = "TrinketFilterSuitTit" (truncated)
.line	0	call          r8     2     0
.line	0	call          r5     0     1
.line	1	self          r5    r2    k7  k= 1 ; k7 = "SetActive"
.line	0	getfield      r7    r4    k8 ; k8 = "UI_Common_Btn_Type_1"
.line	0	loadtrue      r8
.line	0	call          r5     4     1
.line	1	self          r5    r2    k9  k= 1 ; k9 = "BindZ1Button"
.line	0	getfield      r7    r4    k8 ; k8 = "UI_Common_Btn_Type_1"
.line	6	closure       r8    f0
.line	250	call          r5     4     1
.line	7	return        r5     1     0     1

.function	main/f6/f0

.source	null
.linedefined	128
.lastlinedefined	134
.numparams	0
.is_vararg	0
.maxstacksize	7

.upvalue	"_ENV"	0	false
.upvalue	"self"	0	true

.constant	k0	"UIManager"
.constant	k1	"Instance"
.constant	k2	"Reopen"
.constant	k3	"Urls"
.constant	k4	"TrinketFilterSiutPanel"
.constant	k5	"awakerTrinkModel"
.constant	k6	"filterSuits"
.constant	k7	"filterSuitsMap"
.constant	k8	"awakerTrinkModel"

.line	1	gettabup      r0    u0    k0 ; k0 = "UIManager"
.line	0	getfield      r0    r0    k1 ; k1 = "Instance"
.line	0	self          r0    r0    k2  k= 1 ; k2 = "Reopen"
.line	0	gettabup      r2    u0    k3 ; k3 = "Urls"
.line	0	getfield      r2    r2    k4 ; k4 = "TrinketFilterSiutPan" (truncated)
.line	0	gettabup      r3    u1    k5 ; k5 = "awakerTrinkModel"
.line	0	getfield      r3    r3    k6 ; k6 = "filterSuits"
.line	0	gettabup      r4    u1    k7 ; k7 = "filterSuitsMap"
.line	4	closure       r5    f0
.line	0	gettabup      r6    u1    k8 ; k8 = "awakerTrinkModel"
.line	252	call          r0     7     1
.line	5	return0       r0     1     0     0

.function	main/f6/f0/f0

.source	null
.linedefined	130
.lastlinedefined	133
.numparams	1
.is_vararg	0
.maxstacksize	4

.local	"filterSuitsMap"	0	8

.upvalue	"self"	1	false

.constant	k0	"awakerTrinkModel"
.constant	k1	"SetSuitsFilter"
.constant	k2	"RefreshFiltersView"

.line	1	gettabup      r1    u0    k0 ; k0 = "awakerTrinkModel"
.line	0	self          r1    r1    k1  k= 1 ; k1 = "SetSuitsFilter"
.line	0	move          r3    r0
.line	0	call          r1     3     1
.line	1	getupval      r1    u0
.line	0	self          r1    r1    k2  k= 1 ; k2 = "RefreshFiltersView"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0

.function	main/f7

.source	null
.linedefined	137
.lastlinedefined	146
.numparams	4
.is_vararg	0
.maxstacksize	11

.local	"self"	0	32
.local	"cell"	0	32
.local	"binder"	0	32
.local	"cellCfg"	0	32
.local	"uiRes"	5	32

.upvalue	"_ENV"	0	false

.constant	k0	L"UI_Alchemy_Popup_ResolveMaterials_Iten1Resource"
.constant	k1	"gameObject"
.constant	k2	"binder"
.constant	k3	"SetImage"
.constant	k4	"Image_JewelryIcon"
.constant	k5	"awakerTrinkModel"
.constant	k6	"GetSuitIcon"
.constant	k7	"suitId"
.constant	k8	"SetText"
.constant	k9	"Text_JewelryName"
.constant	k10	"GetSuitName"
.constant	k11	"Text_JewelryNum"
.constant	k12	"GetSuitItemNum"
.constant	k13	"BindZ1Button"
.constant	k14	"Btn_Close"

.line	1	getupval      r4    u0
.line	0	loadk         r5    k0 ; k0 = L"UI_Alchemy_Popup_Res" (truncated)
.line	0	gettable      r4    r4    r5
.line	0	getfield      r5    r1    k1 ; k1 = "gameObject"
.line	0	call          r4     2     2
.line	1	getfield      r5    r0    k2 ; k2 = "binder"
.line	0	self          r5    r5    k3  k= 1 ; k3 = "SetImage"
.line	0	getfield      r7    r4    k4 ; k4 = "Image_JewelryIcon"
.line	0	getfield      r8    r0    k5 ; k5 = "awakerTrinkModel"
.line	0	self          r8    r8    k6  k= 1 ; k6 = "GetSuitIcon"
.line	0	getfield     r10    r3    k7 ; k7 = "suitId"
.line	0	call          r8     3     0
.line	0	call          r5     0     1
.line	1	self          r5    r2    k8  k= 1 ; k8 = "SetText"
.line	0	getfield      r7    r4    k9 ; k9 = "Text_JewelryName"
.line	0	getfield      r8    r0    k5 ; k5 = "awakerTrinkModel"
.line	0	self          r8    r8   k10  k= 1 ; k10 = "GetSuitName"
.line	0	getfield     r10    r3    k7 ; k7 = "suitId"
.line	0	call          r8     3     0
.line	0	call          r5     0     1
.line	1	self          r5    r2    k8  k= 1 ; k8 = "SetText"
.line	0	getfield      r7    r4   k11 ; k11 = "Text_JewelryNum"
.line	0	getfield      r8    r0    k5 ; k5 = "awakerTrinkModel"
.line	0	self          r8    r8   k12  k= 1 ; k12 = "GetSuitItemNum"
.line	0	getfield     r10    r3    k7 ; k7 = "suitId"
.line	0	call          r8     3     0
.line	0	call          r5     0     1
.line	1	self          r5    r2   k13  k= 1 ; k13 = "BindZ1Button"
.line	0	getfield      r7    r4   k14 ; k14 = "Btn_Close"
.line	3	closure       r8    f0
.line	253	call          r5     4     1
.line	4	return        r5     1     0     1

.function	main/f7/f0

.source	null
.linedefined	142
.lastlinedefined	145
.numparams	0
.is_vararg	0
.maxstacksize	3

.upvalue	"self"	0	true
.upvalue	"cellCfg"	3	true

.constant	k0	"awakerTrinkModel"
.constant	k1	"CancelSuit"
.constant	k2	"suitId"
.constant	k3	"RefreshFiltersView"

.line	1	gettabup      r0    u0    k0 ; k0 = "awakerTrinkModel"
.line	0	self          r0    r0    k1  k= 1 ; k1 = "CancelSuit"
.line	0	gettabup      r2    u1    k2 ; k2 = "suitId"
.line	0	call          r0     3     1
.line	1	getupval      r0    u0
.line	0	self          r0    r0    k3  k= 1 ; k3 = "RefreshFiltersView"
.line	0	call          r0     2     1
.line	1	return0       r0     1     0     0

.function	main/f8

.source	null
.linedefined	148
.lastlinedefined	152
.numparams	4
.is_vararg	0
.maxstacksize	10

.local	"self"	0	17
.local	"cell"	0	17
.local	"binder"	0	17
.local	"cellCfg"	0	17
.local	"uiRes"	5	17

.upvalue	"_ENV"	0	false

.constant	k0	L"UI_Alchemy_Popup_ResolveMaterials_SiftTitleResource"
.constant	k1	"gameObject"
.constant	k2	"SetText"
.constant	k3	"Text_SiftTitle"
.constant	k4	"LT"
.constant	k5	"Text"
.constant	k6	"TrinketFilterPartTitle"
.constant	k7	"SetActive"
.constant	k8	"UI_Common_Btn_Type_1"

.line	1	getupval      r4    u0
.line	0	loadk         r5    k0 ; k0 = L"UI_Alchemy_Popup_Res" (truncated)
.line	0	gettable      r4    r4    r5
.line	0	getfield      r5    r1    k1 ; k1 = "gameObject"
.line	0	call          r4     2     2
.line	1	self          r5    r2    k2  k= 1 ; k2 = "SetText"
.line	0	getfield      r7    r4    k3 ; k3 = "Text_SiftTitle"
.line	0	gettabup      r8    u0    k4 ; k4 = "LT"
.line	0	getfield      r8    r8    k5 ; k5 = "Text"
.line	0	loadk         r9    k6 ; k6 = "TrinketFilterPartTit" (truncated)
.line	0	call          r8     2     0
.line	0	call          r5     0     1
.line	1	self          r5    r2    k7  k= 1 ; k7 = "SetActive"
.line	0	getfield      r7    r4    k8 ; k8 = "UI_Common_Btn_Type_1"
.line	0	loadfalse     r8
.line	0	call          r5     4     1
.line	1	return0       r5     1     0     0

.function	main/f9

.source	null
.linedefined	154
.lastlinedefined	178
.numparams	4
.is_vararg	0
.maxstacksize	15

.local	"self"	0	28
.local	"cell"	0	28
.local	"binder"	0	28
.local	"cellCfg"	0	28
.local	"group_Btn"	4	28
.local	"(for state)"	11	27
.local	"(for state)"	11	27
.local	"(for state)"	11	27
.local	"i"	12	25
.local	"partBtn"	17	24

.upvalue	"_ENV"	0	false
.upvalue	"TrinketFilterState"	2	true

.constant	k0	"transform"
.constant	k1	"Find"
.constant	k2	"Group_Btn"
.constant	k3	"CommonDefine"
.constant	k4	"MaxEquipTrinketsNum"
.constant	k5	"Btn_Type_"
.constant	k6	"BindZ1Button"
.constant	k7	"gameObject"

.line	1	getfield      r4    r1    k0 ; k0 = "transform"
.line	0	self          r4    r4    k1  k= 1 ; k1 = "Find"
.line	0	loadk         r6    k2 ; k2 = "Group_Btn"
.line	0	call          r4     3     2
.line	1	test          r4     1
.line	0	jmp           l8
.line	1	return        r5     1     0     1
.label	l8
.line	2	loadi         r5     1
.line	0	gettabup      r6    u0    k3 ; k3 = "CommonDefine"
.line	0	getfield      r6    r6    k4 ; k4 = "MaxEquipTrinketsNum"
.line	0	loadi         r7     1
.line	0	forprep       r5   l26
.label	l13
.line	1	self          r9    r4    k1  k= 1 ; k1 = "Find"
.line	0	loadk        r11    k5 ; k5 = "Btn_Type_"
.line	0	move         r12    r8
.line	0	concat       r11     2
.line	0	call          r9     3     2
.line	1	test          r9     0
.line	0	jmp          l27
.line	3	self         r10    r2    k6  k= 1 ; k6 = "BindZ1Button"
.line	0	getfield     r12    r9    k7 ; k7 = "gameObject"
.line	7	closure      r13    f0
.line	5	closure      r14    f1
.line	244	call         r10     5     1
.line	12	close         r8
.label	l26
.line	239	forloop       r5   l13
.label	l27
.line	18	close         r8
.line	1	return        r5     1     0     1

.function	main/f9/f0

.source	null
.linedefined	164
.lastlinedefined	171
.numparams	0
.is_vararg	0
.maxstacksize	4

.upvalue	"cellCfg"	3	true
.upvalue	"i"	8	true
.upvalue	"TrinketFilterState"	1	false
.upvalue	"self"	0	true

.constant	k0	"parts"
.constant	k1	"FilterInclude"
.constant	k2	"awakerTrinkModel"
.constant	k3	"SetPartFilter"
.constant	k4	"FilterExclude"
.constant	k5	"tableview"
.constant	k6	"Refresh"

.line	1	gettabup      r0    u0    k0 ; k0 = "parts"
.line	0	getupval      r1    u1
.line	0	gettable      r0    r0    r1
.line	0	gettabup      r1    u2    k1 ; k1 = "FilterInclude"
.line	0	eq            r0    r1     1
.line	0	jmp          l13
.line	1	gettabup      r0    u3    k2 ; k2 = "awakerTrinkModel"
.line	0	self          r0    r0    k3  k= 1 ; k3 = "SetPartFilter"
.line	0	getupval      r2    u1
.line	0	gettabup      r3    u2    k1 ; k1 = "FilterInclude"
.line	0	call          r0     4     1
.line	0	jmp          l18
.label	l13
.line	2	gettabup      r0    u3    k2 ; k2 = "awakerTrinkModel"
.line	0	self          r0    r0    k3  k= 1 ; k3 = "SetPartFilter"
.line	0	getupval      r2    u1
.line	0	gettabup      r3    u2    k4 ; k4 = "FilterExclude"
.line	0	call          r0     4     1
.label	l18
.line	2	gettabup      r0    u3    k5 ; k5 = "tableview"
.line	0	self          r0    r0    k6  k= 1 ; k6 = "Refresh"
.line	0	call          r0     2     1
.line	1	return0       r0     1     0     0

.function	main/f9/f1

.source	null
.linedefined	171
.lastlinedefined	176
.numparams	0
.is_vararg	0
.maxstacksize	2

.upvalue	"cellCfg"	3	true
.upvalue	"i"	8	true
.upvalue	"TrinketFilterState"	1	false
.upvalue	"_ENV"	0	false

.constant	k0	"parts"
.constant	k1	"FilterInclude"
.constant	k2	"CommonDefine"
.constant	k3	"BtnType"
.constant	k4	"High"
.constant	k5	"Normal"

.line	1	gettabup      r0    u0    k0 ; k0 = "parts"
.line	0	getupval      r1    u1
.line	0	gettable      r0    r0    r1
.line	0	gettabup      r1    u2    k1 ; k1 = "FilterInclude"
.line	0	eq            r0    r1     0
.line	0	jmp          l11
.line	1	gettabup      r0    u3    k2 ; k2 = "CommonDefine"
.line	0	getfield      r0    r0    k3 ; k3 = "BtnType"
.line	0	getfield      r0    r0    k4 ; k4 = "High"
.line	0	return1       r0     2     0     0
.label	l11
.line	2	gettabup      r0    u3    k2 ; k2 = "CommonDefine"
.line	0	getfield      r0    r0    k3 ; k3 = "BtnType"
.line	0	getfield      r0    r0    k5 ; k5 = "Normal"
.line	0	return1       r0     2     0     0
.line	1	return0       r0     1     0     0

.function	main/f10

.source	null
.linedefined	180
.lastlinedefined	191
.numparams	4
.is_vararg	0
.maxstacksize	10

.local	"self"	0	21
.local	"cell"	0	21
.local	"binder"	0	21
.local	"cellCfg"	0	21
.local	"uiRes"	5	21

.upvalue	"_ENV"	0	false

.constant	k0	L"UI_Alchemy_Popup_ResolveMaterials_SiftTitleResource"
.constant	k1	"gameObject"
.constant	k2	"SetText"
.constant	k3	"Text_SiftTitle"
.constant	k4	"LT"
.constant	k5	"Text"
.constant	k6	"TrinketFilterMainAttrTitle"
.constant	k7	"SetActive"
.constant	k8	"UI_Common_Btn_Type_1"
.constant	k9	"BindZ1Button"

.line	1	getupval      r4    u0
.line	0	loadk         r5    k0 ; k0 = L"UI_Alchemy_Popup_Res" (truncated)
.line	0	gettable      r4    r4    r5
.line	0	getfield      r5    r1    k1 ; k1 = "gameObject"
.line	0	call          r4     2     2
.line	1	self          r5    r2    k2  k= 1 ; k2 = "SetText"
.line	0	getfield      r7    r4    k3 ; k3 = "Text_SiftTitle"
.line	0	gettabup      r8    u0    k4 ; k4 = "LT"
.line	0	getfield      r8    r8    k5 ; k5 = "Text"
.line	0	loadk         r9    k6 ; k6 = "TrinketFilterMainAtt" (truncated)
.line	0	call          r8     2     0
.line	0	call          r5     0     1
.line	1	self          r5    r2    k7  k= 1 ; k7 = "SetActive"
.line	0	getfield      r7    r4    k8 ; k8 = "UI_Common_Btn_Type_1"
.line	0	loadtrue      r8
.line	0	call          r5     4     1
.line	1	self          r5    r2    k9  k= 1 ; k9 = "BindZ1Button"
.line	0	getfield      r7    r4    k8 ; k8 = "UI_Common_Btn_Type_1"
.line	6	closure       r8    f0
.line	250	call          r5     4     1
.line	7	return        r5     1     0     1

.function	main/f10/f0

.source	null
.linedefined	184
.lastlinedefined	190
.numparams	0
.is_vararg	0
.maxstacksize	5

.upvalue	"_ENV"	0	false
.upvalue	"self"	0	true

.constant	k0	"UIManager"
.constant	k1	"Instance"
.constant	k2	"Reopen"
.constant	k3	"Urls"
.constant	k4	"TrinketFilterMainAttrsPanel"
.constant	k5	"filterMainAttrs"

.line	1	gettabup      r0    u0    k0 ; k0 = "UIManager"
.line	0	getfield      r0    r0    k1 ; k1 = "Instance"
.line	0	self          r0    r0    k2  k= 1 ; k2 = "Reopen"
.line	0	gettabup      r2    u0    k3 ; k3 = "Urls"
.line	0	getfield      r2    r2    k4 ; k4 = "TrinketFilterMainAtt" (truncated)
.line	1	gettabup      r3    u1    k5 ; k5 = "filterMainAttrs"
.line	3	closure       r4    f0
.line	252	call          r0     5     1
.line	5	return0       r0     1     0     0

.function	main/f10/f0/f0

.source	null
.linedefined	186
.lastlinedefined	189
.numparams	1
.is_vararg	0
.maxstacksize	4

.local	"filterMainAttrs"	0	8

.upvalue	"self"	1	false

.constant	k0	"awakerTrinkModel"
.constant	k1	"SetMainAttrsFilter"
.constant	k2	"RefreshFiltersView"

.line	1	gettabup      r1    u0    k0 ; k0 = "awakerTrinkModel"
.line	0	self          r1    r1    k1  k= 1 ; k1 = "SetMainAttrsFilter"
.line	0	move          r3    r0
.line	0	call          r1     3     1
.line	1	getupval      r1    u0
.line	0	self          r1    r1    k2  k= 1 ; k2 = "RefreshFiltersView"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0

.function	main/f11

.source	null
.linedefined	193
.lastlinedefined	207
.numparams	4
.is_vararg	0
.maxstacksize	18

.local	"self"	0	40
.local	"cell"	0	40
.local	"binder"	0	40
.local	"cellCfg"	0	40
.local	"attrIds"	1	40
.local	"(for state)"	4	39
.local	"(for state)"	4	39
.local	"(for state)"	4	39
.local	"i"	5	38
.local	"mainAttrGo"	11	37
.local	"uiRes"	26	37

.upvalue	"_ENV"	0	false

.constant	k0	"attrIds"
.constant	k1	"transform"
.constant	k2	"GetChild"
.constant	k3	"gameObject"
.constant	k4	"SetActive"
.constant	k5	nil
.constant	k6	L"UI_Alchemy_Popup_ResolveMaterials_Iten2Resource"
.constant	k7	"_FillAttrItem"
.constant	k8	"SetText"
.constant	k9	"TextState"
.constant	k10	""

.line	1	getfield      r4    r3    k0 ; k0 = "attrIds"
.line	1	loadi         r5     1
.line	0	loadi         r6     2
.line	0	loadi         r7     1
.line	0	forprep       r5   l39
.label	l6
.line	1	getfield      r9    r1    k1 ; k1 = "transform"
.line	0	self          r9    r9    k2  k= 1 ; k2 = "GetChild"
.line	0	addi         r11    r8    -1
.line	0	mmbini        r8     1     7     0
.line	0	call          r9     3     2
.line	0	getfield      r9    r9    k3 ; k3 = "gameObject"
.line	1	self         r10    r9    k4  k= 1 ; k4 = "SetActive"
.line	0	gettable     r12    r4    r8
.line	0	eqk          r12    k5     0 ; k5 = nil
.line	0	jmp          l17
.line	0	lfalseskip   r12
.label	l17
.line	0	loadtrue     r12
.line	0	call         r10     3     1
.line	1	gettable     r10    r4    r8
.line	0	test         r10     0
.line	0	jmp          l38
.line	1	getupval     r10    u0
.line	0	loadk        r11    k6 ; k6 = L"UI_Alchemy_Popup_Res" (truncated)
.line	0	gettable     r10   r10   r11
.line	0	move         r11    r9
.line	0	call         r10     2     2
.line	1	self         r11    r0    k7  k= 1 ; k7 = "_FillAttrItem"
.line	0	move         r13    r2
.line	0	move         r14   r10
.line	0	move         r15    r9
.line	0	gettable     r16    r4    r8
.line	3	closure      r17    f0
.line	253	call         r11     7     1
.line	4	self         r11    r2    k8  k= 1 ; k8 = "SetText"
.line	0	getfield     r13   r10    k9 ; k9 = "TextState"
.line	0	loadk        r14   k10 ; k10 = ""
.line	0	call         r11     4     1
.label	l38
.line	1	close         r8
.label	l39
.line	246	forloop       r5    l6
.line	12	return        r5     1     0     1

.function	main/f11/f0

.source	null
.linedefined	200
.lastlinedefined	203
.numparams	0
.is_vararg	0
.maxstacksize	4

.upvalue	"self"	0	true
.upvalue	"attrIds"	4	true
.upvalue	"i"	8	true

.constant	k0	"awakerTrinkModel"
.constant	k1	"CancelMainAttr"
.constant	k2	"RefreshFiltersView"

.line	1	gettabup      r0    u0    k0 ; k0 = "awakerTrinkModel"
.line	0	self          r0    r0    k1  k= 1 ; k1 = "CancelMainAttr"
.line	0	getupval      r3    u2
.line	0	getupval      r2    u1
.line	0	gettable      r2    r2    r3
.line	0	call          r0     3     1
.line	1	getupval      r0    u0
.line	0	self          r0    r0    k2  k= 1 ; k2 = "RefreshFiltersView"
.line	0	call          r0     2     1
.line	1	return0       r0     1     0     0

.function	main/f12

.source	null
.linedefined	209
.lastlinedefined	220
.numparams	4
.is_vararg	0
.maxstacksize	10

.local	"self"	0	21
.local	"cell"	0	21
.local	"binder"	0	21
.local	"cellCfg"	0	21
.local	"uiRes"	5	21

.upvalue	"_ENV"	0	false

.constant	k0	L"UI_Alchemy_Popup_ResolveMaterials_SiftTitleResource"
.constant	k1	"gameObject"
.constant	k2	"SetText"
.constant	k3	"Text_SiftTitle"
.constant	k4	"LT"
.constant	k5	"Text"
.constant	k6	"TrinketFilterSubAttrTitle"
.constant	k7	"SetActive"
.constant	k8	"UI_Common_Btn_Type_1"
.constant	k9	"BindZ1Button"

.line	1	getupval      r4    u0
.line	0	loadk         r5    k0 ; k0 = L"UI_Alchemy_Popup_Res" (truncated)
.line	0	gettable      r4    r4    r5
.line	0	getfield      r5    r1    k1 ; k1 = "gameObject"
.line	0	call          r4     2     2
.line	1	self          r5    r2    k2  k= 1 ; k2 = "SetText"
.line	0	getfield      r7    r4    k3 ; k3 = "Text_SiftTitle"
.line	0	gettabup      r8    u0    k4 ; k4 = "LT"
.line	0	getfield      r8    r8    k5 ; k5 = "Text"
.line	0	loadk         r9    k6 ; k6 = "TrinketFilterSubAttr" (truncated)
.line	0	call          r8     2     0
.line	0	call          r5     0     1
.line	1	self          r5    r2    k7  k= 1 ; k7 = "SetActive"
.line	0	getfield      r7    r4    k8 ; k8 = "UI_Common_Btn_Type_1"
.line	0	loadtrue      r8
.line	0	call          r5     4     1
.line	1	self          r5    r2    k9  k= 1 ; k9 = "BindZ1Button"
.line	0	getfield      r7    r4    k8 ; k8 = "UI_Common_Btn_Type_1"
.line	6	closure       r8    f0
.line	250	call          r5     4     1
.line	7	return        r5     1     0     1

.function	main/f12/f0

.source	null
.linedefined	213
.lastlinedefined	219
.numparams	0
.is_vararg	0
.maxstacksize	5

.upvalue	"_ENV"	0	false
.upvalue	"self"	0	true

.constant	k0	"UIManager"
.constant	k1	"Instance"
.constant	k2	"Reopen"
.constant	k3	"Urls"
.constant	k4	"TrinketFilterSubAttrsPanel"
.constant	k5	"filterSubAttrs"

.line	1	gettabup      r0    u0    k0 ; k0 = "UIManager"
.line	0	getfield      r0    r0    k1 ; k1 = "Instance"
.line	0	self          r0    r0    k2  k= 1 ; k2 = "Reopen"
.line	0	gettabup      r2    u0    k3 ; k3 = "Urls"
.line	0	getfield      r2    r2    k4 ; k4 = "TrinketFilterSubAttr" (truncated)
.line	1	gettabup      r3    u1    k5 ; k5 = "filterSubAttrs"
.line	3	closure       r4    f0
.line	252	call          r0     5     1
.line	5	return0       r0     1     0     0

.function	main/f12/f0/f0

.source	null
.linedefined	215
.lastlinedefined	218
.numparams	1
.is_vararg	0
.maxstacksize	4

.local	"filterSubAttrs"	0	8

.upvalue	"self"	1	false

.constant	k0	"awakerTrinkModel"
.constant	k1	"SetSubAttrsFilter"
.constant	k2	"RefreshFiltersView"

.line	1	gettabup      r1    u0    k0 ; k0 = "awakerTrinkModel"
.line	0	self          r1    r1    k1  k= 1 ; k1 = "SetSubAttrsFilter"
.line	0	move          r3    r0
.line	0	call          r1     3     1
.line	1	getupval      r1    u0
.line	0	self          r1    r1    k2  k= 1 ; k2 = "RefreshFiltersView"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0

.function	main/f13

.source	null
.linedefined	222
.lastlinedefined	240
.numparams	4
.is_vararg	0
.maxstacksize	18

.local	"self"	0	57
.local	"cell"	0	57
.local	"binder"	0	57
.local	"cellCfg"	0	57
.local	"attrIds"	1	57
.local	"(for state)"	4	56
.local	"(for state)"	4	56
.local	"(for state)"	4	56
.local	"i"	5	55
.local	"subAttrGo"	11	54
.local	"uiRes"	26	54

.upvalue	"_ENV"	0	false
.upvalue	"TrinketFilterState"	2	true

.constant	k0	"attrIds"
.constant	k1	"transform"
.constant	k2	"GetChild"
.constant	k3	"gameObject"
.constant	k4	"SetActive"
.constant	k5	nil
.constant	k6	L"UI_Alchemy_Popup_ResolveMaterials_Iten2Resource"
.constant	k7	"_FillAttrItem"
.constant	k8	"filterSubAttrs"
.constant	k9	"FilterExclude"
.constant	k10	"SetText"
.constant	k11	"TextState"
.constant	k12	"LT"
.constant	k13	"Text"
.constant	k14	"SelectTrinketNo"
.constant	k15	"SelectTrinketHave"

.line	1	getfield      r4    r3    k0 ; k0 = "attrIds"
.line	1	loadi         r5     1
.line	0	loadi         r6     2
.line	0	loadi         r7     1
.line	0	forprep       r5   l56
.label	l6
.line	1	getfield      r9    r1    k1 ; k1 = "transform"
.line	0	self          r9    r9    k2  k= 1 ; k2 = "GetChild"
.line	0	addi         r11    r8    -1
.line	0	mmbini        r8     1     7     0
.line	0	call          r9     3     2
.line	0	getfield      r9    r9    k3 ; k3 = "gameObject"
.line	1	self         r10    r9    k4  k= 1 ; k4 = "SetActive"
.line	0	gettable     r12    r4    r8
.line	0	eqk          r12    k5     0 ; k5 = nil
.line	0	jmp          l17
.line	0	lfalseskip   r12
.label	l17
.line	0	loadtrue     r12
.line	0	call         r10     3     1
.line	1	gettable     r10    r4    r8
.line	0	test         r10     0
.line	0	jmp          l55
.line	1	getupval     r10    u0
.line	0	loadk        r11    k6 ; k6 = L"UI_Alchemy_Popup_Res" (truncated)
.line	0	gettable     r10   r10   r11
.line	0	move         r11    r9
.line	0	call         r10     2     2
.line	1	self         r11    r0    k7  k= 1 ; k7 = "_FillAttrItem"
.line	0	move         r13    r2
.line	0	move         r14   r10
.line	0	move         r15    r9
.line	0	gettable     r16    r4    r8
.line	3	closure      r17    f0
.line	253	call         r11     7     1
.line	4	getfield     r11    r0    k8 ; k8 = "filterSubAttrs"
.line	0	gettable     r12    r4    r8
.line	0	gettable     r11   r11   r12
.line	0	gettabup     r12    u1    k9 ; k9 = "FilterExclude"
.line	0	eq           r11   r12     0
.line	0	jmp          l48
.line	1	self         r11    r2   k10  k= 1 ; k10 = "SetText"
.line	0	getfield     r13   r10   k11 ; k11 = "TextState"
.line	0	gettabup     r14    u0   k12 ; k12 = "LT"
.line	0	getfield     r14   r14   k13 ; k13 = "Text"
.line	0	loadk        r15   k14 ; k14 = "SelectTrinketNo"
.line	0	call         r14     2     0
.line	0	call         r11     0     1
.line	0	jmp          l55
.label	l48
.line	2	self         r11    r2   k10  k= 1 ; k10 = "SetText"
.line	0	getfield     r13   r10   k11 ; k11 = "TextState"
.line	0	gettabup     r14    u0   k12 ; k12 = "LT"
.line	0	getfield     r14   r14   k13 ; k13 = "Text"
.line	0	loadk        r15   k15 ; k15 = "SelectTrinketHave"
.line	0	call         r14     2     0
.line	0	call         r11     0     1
.label	l55
.line	2	close         r8
.label	l56
.line	242	forloop       r5    l6
.line	16	return        r5     1     0     1

.function	main/f13/f0

.source	null
.linedefined	229
.lastlinedefined	232
.numparams	0
.is_vararg	0
.maxstacksize	4

.upvalue	"self"	0	true
.upvalue	"attrIds"	4	true
.upvalue	"i"	8	true

.constant	k0	"awakerTrinkModel"
.constant	k1	"CancelSubAttr"
.constant	k2	"RefreshFiltersView"

.line	1	gettabup      r0    u0    k0 ; k0 = "awakerTrinkModel"
.line	0	self          r0    r0    k1  k= 1 ; k1 = "CancelSubAttr"
.line	0	getupval      r3    u2
.line	0	getupval      r2    u1
.line	0	gettable      r2    r2    r3
.line	0	call          r0     3     1
.line	1	getupval      r0    u0
.line	0	self          r0    r0    k2  k= 1 ; k2 = "RefreshFiltersView"
.line	0	call          r0     2     1
.line	1	return0       r0     1     0     0

.function	main/f14

.source	null
.linedefined	242
.lastlinedefined	247
.numparams	6
.is_vararg	0
.maxstacksize	12

.local	"self"	0	21
.local	"binder"	0	21
.local	"uiRes"	0	21
.local	"attrGo"	0	21
.local	"attrId"	0	21
.local	"callback"	0	21
.local	"attrType"	3	21

.upvalue	"_ENV"	0	false

.constant	k0	"DT"
.constant	k1	"ActorAttrType"
.constant	k2	"binder"
.constant	k3	"SetImage"
.constant	k4	"Image_Icon"
.constant	k5	"Icon"
.constant	k6	"SetText"
.constant	k7	"Text_JewelryName"
.constant	k8	"LT"
.constant	k9	"Text"
.constant	k10	"BindZ1Button"
.constant	k11	"Btn_Close"

.line	1	gettabup      r6    u0    k0 ; k0 = "DT"
.line	0	getfield      r6    r6    k1 ; k1 = "ActorAttrType"
.line	0	gettable      r6    r6    r4
.line	1	getfield      r7    r0    k2 ; k2 = "binder"
.line	0	self          r7    r7    k3  k= 1 ; k3 = "SetImage"
.line	0	getfield      r9    r2    k4 ; k4 = "Image_Icon"
.line	0	getfield     r10    r6    k5 ; k5 = "Icon"
.line	0	call          r7     4     1
.line	1	getfield      r7    r0    k2 ; k2 = "binder"
.line	0	self          r7    r7    k6  k= 1 ; k6 = "SetText"
.line	0	getfield      r9    r2    k7 ; k7 = "Text_JewelryName"
.line	0	gettabup     r10    u0    k8 ; k8 = "LT"
.line	0	getfield     r10   r10    k9 ; k9 = "Text"
.line	0	getfield     r11    r6    k9 ; k9 = "Text"
.line	0	call         r10     2     0
.line	0	call          r7     0     1
.line	1	self          r7    r1   k10  k= 1 ; k10 = "BindZ1Button"
.line	0	getfield      r9    r2   k11 ; k11 = "Btn_Close"
.line	0	move         r10    r5
.line	0	call          r7     4     1
.line	1	return0       r7     1     0     0

.function	main/f15

.source	null
.linedefined	249
.lastlinedefined	279
.numparams	1
.is_vararg	0
.maxstacksize	14

.local	"self"	0	123
.local	"suits"	6	123
.local	"mainAttrs"	9	123
.local	"subAttrs"	12	123
.local	"(for state)"	28	40
.local	"(for state)"	28	40
.local	"(for state)"	28	40
.local	"i"	29	39
.local	"(for state)"	75	93
.local	"(for state)"	75	93
.local	"(for state)"	75	93
.local	"i"	76	92
.local	"(for state)"	104	122
.local	"(for state)"	104	122
.local	"(for state)"	104	122
.local	"i"	105	121

.upvalue	"_ENV"	0	false
.upvalue	"TableCellType"	7	true

.constant	k0	"filterViewsData"
.constant	k1	"_KeysToArray"
.constant	k2	"filterSuitsMap"
.constant	k3	"filterMainAttrs"
.constant	k4	"_SubAttrKeysToArray"
.constant	k5	"filterSubAttrs"
.constant	k6	"table"
.constant	k7	"insert"
.constant	k8	"tableCellType"
.constant	k9	"SuitTitle"
.constant	k10	"Suit"
.constant	k11	"suitId"
.constant	k12	"selectPos"
.constant	k13	"PartTitle"
.constant	k14	"Part"
.constant	k15	"parts"
.constant	k16	"filterParts"
.constant	k17	"MainAttrTitle"
.constant	k18	"MainAttr"
.constant	k19	"attrIds"
.constant	k20	"SubAttrTitle"
.constant	k21	"SubAttr"

.line	1	newtable      r1     0     0     1
.line	0	extraarg       0
.line	0	setfield      r0    k0    r1 ; k0 = "filterViewsData"
.line	1	self          r1    r0    k1  k= 1 ; k1 = "_KeysToArray"
.line	0	getfield      r3    r0    k2 ; k2 = "filterSuitsMap"
.line	0	call          r1     3     2
.line	1	self          r2    r0    k1  k= 1 ; k1 = "_KeysToArray"
.line	0	getfield      r4    r0    k3 ; k3 = "filterMainAttrs"
.line	0	call          r2     3     2
.line	1	self          r3    r0    k4  k= 1 ; k4 = "_SubAttrKeysToArray"
.line	0	getfield      r5    r0    k5 ; k5 = "filterSubAttrs"
.line	0	call          r3     3     2
.line	1	test          r1     1
.line	0	jmp          l18
.line	0	newtable      r4     0     0     1
.line	0	extraarg       0
.line	0	move          r1    r4
.label	l18
.line	1	gettabup      r4    u0    k6 ; k6 = "table"
.line	0	getfield      r4    r4    k7 ; k7 = "insert"
.line	0	getfield      r5    r0    k0 ; k0 = "filterViewsData"
.line	0	newtable      r6     1     0     1
.line	0	extraarg       0
.line	0	gettabup      r7    u1    k9 ; k9 = "SuitTitle"
.line	0	setfield      r6    k8    r7 ; k8 = "tableCellType"
.line	0	call          r4     3     1
.line	1	loadi         r4     1
.line	0	len           r5    r1
.line	0	loadi         r6     1
.line	0	forprep       r4   l40
.label	l30
.line	1	gettabup      r8    u0    k6 ; k6 = "table"
.line	0	getfield      r8    r8    k7 ; k7 = "insert"
.line	0	getfield      r9    r0    k0 ; k0 = "filterViewsData"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	0	gettabup     r11    u1   k10 ; k10 = "Suit"
.line	0	setfield     r10    k8   r11 ; k8 = "tableCellType"
.line	0	gettable     r11    r1    r7
.line	0	setfield     r10   k11   r11 ; k11 = "suitId"
.line	0	call          r8     3     1
.label	l40
.line	255	forloop       r4   l30
.line	3	getfield      r4    r0   k12 ; k12 = "selectPos"
.line	0	test          r4     0
.line	0	jmp          l47
.line	0	getfield      r4    r0   k12 ; k12 = "selectPos"
.line	0	eqi           r4     0     0     0
.line	0	jmp          l65
.label	l47
.line	1	gettabup      r4    u0    k6 ; k6 = "table"
.line	0	getfield      r4    r4    k7 ; k7 = "insert"
.line	0	getfield      r5    r0    k0 ; k0 = "filterViewsData"
.line	0	newtable      r6     1     0     1
.line	0	extraarg       0
.line	0	gettabup      r7    u1   k13 ; k13 = "PartTitle"
.line	0	setfield      r6    k8    r7 ; k8 = "tableCellType"
.line	0	call          r4     3     1
.line	1	gettabup      r4    u0    k6 ; k6 = "table"
.line	0	getfield      r4    r4    k7 ; k7 = "insert"
.line	0	getfield      r5    r0    k0 ; k0 = "filterViewsData"
.line	0	newtable      r6     2     0     1
.line	0	extraarg       0
.line	0	gettabup      r7    u1   k14 ; k14 = "Part"
.line	0	setfield      r6    k8    r7 ; k8 = "tableCellType"
.line	0	getfield      r7    r0   k16 ; k16 = "filterParts"
.line	0	setfield      r6   k15    r7 ; k15 = "parts"
.line	0	call          r4     3     1
.label	l65
.line	2	gettabup      r4    u0    k6 ; k6 = "table"
.line	0	getfield      r4    r4    k7 ; k7 = "insert"
.line	0	getfield      r5    r0    k0 ; k0 = "filterViewsData"
.line	0	newtable      r6     1     0     1
.line	0	extraarg       0
.line	0	gettabup      r7    u1   k17 ; k17 = "MainAttrTitle"
.line	0	setfield      r6    k8    r7 ; k8 = "tableCellType"
.line	0	call          r4     3     1
.line	1	loadi         r4     1
.line	0	len           r5    r2
.line	0	loadi         r6     2
.line	0	forprep       r4   l93
.label	l77
.line	1	gettabup      r8    u0    k6 ; k6 = "table"
.line	0	getfield      r8    r8    k7 ; k7 = "insert"
.line	0	getfield      r9    r0    k0 ; k0 = "filterViewsData"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	1	gettabup     r11    u1   k18 ; k18 = "MainAttr"
.line	0	setfield     r10    k8   r11 ; k8 = "tableCellType"
.line	1	newtable     r11     0     2     1
.line	0	extraarg       0
.line	0	gettable     r12    r2    r7
.line	0	addi         r13    r7     1
.line	0	mmbini        r7     1     6     0
.line	0	gettable     r13    r2   r13
.line	0	setlist      r11     2     0     0
.line	0	setfield     r10   k19   r11 ; k19 = "attrIds"
.line	254	call          r8     3     1
.label	l93
.line	255	forloop       r4   l77
.line	7	gettabup      r4    u0    k6 ; k6 = "table"
.line	0	getfield      r4    r4    k7 ; k7 = "insert"
.line	0	getfield      r5    r0    k0 ; k0 = "filterViewsData"
.line	0	newtable      r6     1     0     1
.line	0	extraarg       0
.line	0	gettabup      r7    u1   k20 ; k20 = "SubAttrTitle"
.line	0	setfield      r6    k8    r7 ; k8 = "tableCellType"
.line	0	call          r4     3     1
.line	1	loadi         r4     1
.line	0	len           r5    r3
.line	0	loadi         r6     2
.line	0	forprep       r4  l122
.label	l106
.line	1	gettabup      r8    u0    k6 ; k6 = "table"
.line	0	getfield      r8    r8    k7 ; k7 = "insert"
.line	0	getfield      r9    r0    k0 ; k0 = "filterViewsData"
.line	0	newtable     r10     2     0     1
.line	0	extraarg       0
.line	1	gettabup     r11    u1   k21 ; k21 = "SubAttr"
.line	0	setfield     r10    k8   r11 ; k8 = "tableCellType"
.line	1	newtable     r11     0     2     1
.line	0	extraarg       0
.line	0	gettable     r12    r3    r7
.line	0	addi         r13    r7     1
.line	0	mmbini        r7     1     6     0
.line	0	gettable     r13    r3   r13
.line	0	setlist      r11     2     0     0
.line	0	setfield     r10   k19   r11 ; k19 = "attrIds"
.line	254	call          r8     3     1
.label	l122
.line	255	forloop       r4  l106
.line	7	return0       r4     1     0     0

.function	main/f16

.source	null
.linedefined	281
.lastlinedefined	289
.numparams	2
.is_vararg	0
.maxstacksize	12

.local	"self"	0	19
.local	"map"	0	19
.local	"array"	2	19
.local	"(for state)"	5	17
.local	"(for state)"	5	17
.local	"(for state)"	5	17
.local	"(for state)"	5	17
.local	"k"	6	14
.local	"v"	6	14

.upvalue	"_ENV"	0	false
.upvalue	"TrinketFilterState"	2	true

.constant	k0	"pairs"
.constant	k1	"FilterInclude"
.constant	k2	"table"
.constant	k3	"insert"

.line	1	newtable      r2     0     0     1
.line	0	extraarg       0
.line	1	gettabup      r3    u0    k0 ; k0 = "pairs"
.line	0	move          r4    r1
.line	0	call          r3     2     5
.line	0	tforprep      r3   l15
.label	l7
.line	1	gettabup      r9    u1    k1 ; k1 = "FilterInclude"
.line	0	eq            r8    r9     0
.line	0	jmp          l15
.line	1	gettabup      r9    u0    k2 ; k2 = "table"
.line	0	getfield      r9    r9    k3 ; k3 = "insert"
.line	0	move         r10    r2
.line	0	move         r11    r7
.line	0	call          r9     3     1
.label	l15
.line	254	tforcall      r3     2
.line	0	tforloop      r3    l7
.line	4	close         r3
.line	1	return        r2     2     0     1
.line	1	return        r3     1     0     1

.function	main/f17

.source	null
.linedefined	291
.lastlinedefined	299
.numparams	2
.is_vararg	0
.maxstacksize	12

.local	"self"	0	19
.local	"filters"	0	19
.local	"array"	2	19
.local	"(for state)"	5	17
.local	"(for state)"	5	17
.local	"(for state)"	5	17
.local	"(for state)"	5	17
.local	"k"	6	14
.local	"v"	6	14

.upvalue	"_ENV"	0	false
.upvalue	"TrinketFilterState"	2	true

.constant	k0	"pairs"
.constant	k1	"FilterDefault"
.constant	k2	"table"
.constant	k3	"insert"

.line	1	newtable      r2     0     0     1
.line	0	extraarg       0
.line	1	gettabup      r3    u0    k0 ; k0 = "pairs"
.line	0	move          r4    r1
.line	0	call          r3     2     5
.line	0	tforprep      r3   l15
.label	l7
.line	1	gettabup      r9    u1    k1 ; k1 = "FilterDefault"
.line	0	eq            r8    r9     1
.line	0	jmp          l15
.line	1	gettabup      r9    u0    k2 ; k2 = "table"
.line	0	getfield      r9    r9    k3 ; k3 = "insert"
.line	0	move         r10    r2
.line	0	move         r11    r7
.line	0	call          r9     3     1
.label	l15
.line	254	tforcall      r3     2
.line	0	tforloop      r3    l7
.line	4	close         r3
.line	1	return        r2     2     0     1
.line	1	return        r3     1     0     1

.function	main/f18

.source	null
.linedefined	301
.lastlinedefined	326
.numparams	1
.is_vararg	0
.maxstacksize	8

.local	"self"	0	55
.local	"(for state)"	3	13
.local	"(for state)"	3	13
.local	"(for state)"	3	13
.local	"(for state)"	3	13
.local	"k"	4	10
.local	"v"	4	10
.local	"(for state)"	16	26
.local	"(for state)"	16	26
.local	"(for state)"	16	26
.local	"(for state)"	16	26
.local	"k"	17	23
.local	"v"	17	23
.local	"(for state)"	29	39
.local	"(for state)"	29	39
.local	"(for state)"	29	39
.local	"(for state)"	29	39
.local	"k"	30	36
.local	"v"	30	36
.local	"(for state)"	42	52
.local	"(for state)"	42	52
.local	"(for state)"	42	52
.local	"(for state)"	42	52
.local	"k"	43	49
.local	"v"	43	49

.upvalue	"_ENV"	0	false

.constant	k0	"pairs"
.constant	k1	"filterSuitsMap"
.constant	k2	"saveSuitsStatus"
.constant	k3	"filterParts"
.constant	k4	"savePartsStatus"
.constant	k5	"filterMainAttrs"
.constant	k6	"saveMainAttrsStatus"
.constant	k7	"filterSubAttrs"
.constant	k8	"saveSubAttrsStatus"

.line	1	gettabup      r1    u0    k0 ; k0 = "pairs"
.line	0	getfield      r2    r0    k1 ; k1 = "filterSuitsMap"
.line	0	call          r1     2     5
.line	0	tforprep      r1   l11
.label	l5
.line	1	getfield      r7    r0    k2 ; k2 = "saveSuitsStatus"
.line	0	gettable      r7    r7    r5
.line	0	eq            r7    r6     1
.line	0	jmp          l11
.line	1	loadtrue      r7
.line	0	return        r7     2     0     1
.label	l11
.line	254	tforcall      r1     2
.line	0	tforloop      r1    l5
.line	4	close         r1
.line	1	gettabup      r1    u0    k0 ; k0 = "pairs"
.line	0	getfield      r2    r0    k3 ; k3 = "filterParts"
.line	0	call          r1     2     5
.line	0	tforprep      r1   l24
.label	l18
.line	1	getfield      r7    r0    k4 ; k4 = "savePartsStatus"
.line	0	gettable      r7    r7    r5
.line	0	eq            r7    r6     1
.line	0	jmp          l24
.line	1	loadtrue      r7
.line	0	return        r7     2     0     1
.label	l24
.line	254	tforcall      r1     2
.line	0	tforloop      r1   l18
.line	4	close         r1
.line	2	gettabup      r1    u0    k0 ; k0 = "pairs"
.line	0	getfield      r2    r0    k5 ; k5 = "filterMainAttrs"
.line	0	call          r1     2     5
.line	0	tforprep      r1   l37
.label	l31
.line	1	getfield      r7    r0    k6 ; k6 = "saveMainAttrsStatus"
.line	0	gettable      r7    r7    r5
.line	0	eq            r7    r6     1
.line	0	jmp          l37
.line	1	loadtrue      r7
.line	0	return        r7     2     0     1
.label	l37
.line	254	tforcall      r1     2
.line	0	tforloop      r1   l31
.line	4	close         r1
.line	2	gettabup      r1    u0    k0 ; k0 = "pairs"
.line	0	getfield      r2    r0    k7 ; k7 = "filterSubAttrs"
.line	0	call          r1     2     5
.line	0	tforprep      r1   l50
.label	l44
.line	1	getfield      r7    r0    k8 ; k8 = "saveSubAttrsStatus"
.line	0	gettable      r7    r7    r5
.line	0	eq            r7    r6     1
.line	0	jmp          l50
.line	1	loadtrue      r7
.line	0	return        r7     2     0     1
.label	l50
.line	254	tforcall      r1     2
.line	0	tforloop      r1   l44
.line	4	close         r1
.line	2	loadfalse     r1
.line	0	return        r1     2     0     1
.line	1	return        r1     1     0     1

.function	main/f19

.source	null
.linedefined	328
.lastlinedefined	330
.numparams	1
.is_vararg	0
.maxstacksize	3

.local	"self"	0	3

.constant	k0	"Close"

.line	1	self          r1    r0    k0  k= 1 ; k0 = "Close"
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0

.function	main/f20

.source	null
.linedefined	332
.lastlinedefined	337
.numparams	1
.is_vararg	0
.maxstacksize	4

.local	"self"	0	11

.upvalue	"Super"	1	true

.constant	k0	"closeFunc"
.constant	k1	"IsFilterChanged"
.constant	k2	"Close"

.line	1	getfield      r1    r0    k0 ; k0 = "closeFunc"
.line	0	test          r1     0
.line	0	jmp           l8
.line	1	getfield      r1    r0    k0 ; k0 = "closeFunc"
.line	0	self          r2    r0    k1  k= 1 ; k1 = "IsFilterChanged"
.line	0	call          r2     2     0
.line	0	call          r1     0     1
.label	l8
.line	2	gettabup      r1    u0    k2 ; k2 = "Close"
.line	0	move          r2    r0
.line	0	call          r1     2     1
.line	1	return0       r1     1     0     0

