LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/trunk/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2903601/cfg_skill_view_20006091.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  � A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=20006093,remove=1; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; ��       PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID=7017,audioType=1; Wait,waitTime=2500; DataSelectResult,effectType=96,index=1; PlayTargetBindEffect,effectID=2436; Wait,waitTime=500; PlayRoleTeleport,type=10, onlySelf=1; Wait,waitTime=1000; DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=doAgain; PlayTargetAddBuff,buffID=29036012; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; Wait,waitTime=1000;         %                                                                                                                     key   %   config    %      _ENV