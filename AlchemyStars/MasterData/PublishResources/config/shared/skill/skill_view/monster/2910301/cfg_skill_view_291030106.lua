LuaS �

xV           (w@a@../PublishResources/config/shared/skill/skill_view/monster/2910301/cfg_skill_view_291030106.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  B  A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               � PlayCasterAnimation,animName=Atk2; PlayCasterBindEffect,effectID =291030101; PlayCasterVisible,visible=1; PlayCasterMaterialAnim,animName=eff_2910301_skill02_shadow_in; PlayAudio,audioID=6275,audioType=1; Wait,waitTime=1200; �Q       DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd,label=buffLoop; PlayTargetAddBuff,buffID=291030101; PlayTargetAddBuff,buffID=291030101; PlayTargetAddBuff,buffID=291030102; PlayTargetAddBuff,buffID=291030102; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=1000;        %                                                                                                                     key   %   config    %      _ENV