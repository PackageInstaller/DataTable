local L0_1, L1_1, L2_1, L3_1, L4_1
L0_1 = {}
L0_1.BASE_UNIT_STR_ID = "NKM_MONSTER_BOSS_BASIC_BEAST_BASIC_N"
L1_1 = {}
L2_1 = {}
L2_1.m_StateName = "USN_ATTACK1"
L3_1 = {}
L4_1 = {}
L4_1.m_DamageTempletName = "DT_NKM_MONSTER_BOSS_TRANS_BEAST_BASIC_ATTACK1"
L3_1[1] = L4_1
L2_1.m_listNKMEventAttack = L3_1
L1_1[1] = L2_1
L0_1.m_dicNKMUnitState = L1_1
NKMUnitTemplet = L0_1
