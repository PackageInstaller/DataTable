LuaS �

xV           (w@j@../PublishResources/lua/product/core_game/logic/svc/buff_logic_handler/bl_add_pet_legend_power_by_hp.lua             @ A@  ��@ $@�@@  ��@@ l   
@��@@ l@  
@ �& �    _classBuffLogicAddPetLegendPowerByHPBuffLogicBaseConstructorDoLogic                  �@@
� ���@
� �& �    	_hpLimithpLimit_unitPowerValunitPowerVal                             self       buffInstance       logicParam            
   N    v   G @ L@� d� b@    �& � ��@ ��@ ����@A@� ���N� R���A ��A�B ����� !@B  �& � ƁA ����B �B� � $� LBC�� d�����C �� ��@ ���C ���BDA� � �B �  �� $� �D$� G�@ L��� d���C�  ���ǃ@ ���A� 䃀���� ��$D   LFd� !��@�L���� E dD �� F�F L���� d����@ ��@	 ����DG	 ��D��  �L���� E dD �  LFd� a@�  �CD  C� ��� �� ��G	� H �F
��	�  �@�$� "  � �LEH
̅� � dE  & & � #   _buffInstanceEntity_worldGetServiceBattleGetCasterHPmathfloor	_hpLimit        _unitPowerVal      �?AttributesGetAttributeLegendPowerBattleConstLegendPowerMaxModify
SkillInfoGetActiveSkillIDConfigGetSkillConfigData
BuffLogicChangePetActiveSkillReadyGetSkillTriggerParam       NTPowerReadyNewTriggerNotify	PetPstID	GetPstID BuffResultAddPetLegendPowerByHPRequireNTPowerReadyGetID         v                                                                                                            "   #   #   #   #   $   $   &   &   &   &   (   *   *   *   *   -   -   -   -   /   /   /   2   2   2   2   3   3   3   3   5   7   7   7   7   8   8   8   8   9   ;   ;   ;   ;   <   <   <   <   <   <   <   =   =   ?   ?   ?   ?   @   D   D   D   D   D   D   F   F   G   G   I   I   I   I   I   I   I   J   J   K   K   K   K   M   N      self    v   
petEntity   v   battleService
   v   hp   v   maxHP   v   costHPPercent   v   count   v   val   v   curAttributeCmpt   v   curLegendPower"   v   	newPower#   v   ready.   v   activeSkillID2   v   configService6   v   skillConfigData9   v   blsvc=   v   requireNTPowerReadyB   v   notifyO   W   previouslyReadyc   v   petPstIDComponente   v   	petPstIDg   v   resultn   v      _ENV                              
   N   
   N          _ENV