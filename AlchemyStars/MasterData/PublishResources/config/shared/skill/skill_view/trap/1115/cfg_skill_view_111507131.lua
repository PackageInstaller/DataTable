LuaS �

xV           (w@[@../PublishResources/config/shared/skill/skill_view/trap/1115/cfg_skill_view_111507131.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� ��  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               �c       PlayCasterBindEffect,effectID=PARAM.Disappear; PlayCasterShowLineRenderer,show=0; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=400; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=PARAM.Appear; Wait,waitTime=200; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterShowLineRenderer,show=1; Wait,waitTime=200; �        PlayAddHpText; Wait,waitTime=200; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=PARAM.buffID1; PlayTargetAddBuff,buffID=PARAM.buffID2; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop;         %                                                                                                                     key   %   config    %      _ENV