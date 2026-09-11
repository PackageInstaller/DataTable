return {
	Play325581001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325581001
		arg_1_1.duration_ = 7.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325581002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J21h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21h")
				var_4_0.name = "J21h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J21h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J21h

				arg_1_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J21h" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "10162ui_story"

			if arg_1_1.actors_["10162ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10162ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["10162ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10162ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10162ui_story, Vector3.New(0, -1.08, -5.83), (arg_1_1.time_ - 1.8) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -1.08, -5.83)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["10162ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect10162ui_story == nil then
				arg_1_1.var_.characterEffect10162ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect10162ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect10162ui_story then
				arg_1_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.6

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(325581001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 24 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 24)

				if (24 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 24)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581001", "story_v_out_325581.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_325581", "325581001", "story_v_out_325581.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_325581", "325581001", "story_v_out_325581.awb")

						arg_1_1:RecordAudio("325581001", var_4_32)
						arg_1_1:RecordAudio("325581001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_325581", "325581001", "story_v_out_325581.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_325581", "325581001", "story_v_out_325581.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play325581002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325581002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325581003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10162ui_story = arg_8_1.actors_["10162ui_story"].transform.localPosition

				local var_11_0 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_0 then
					var_11_0:EnableDynamicBone(false)
				end
			end

			local var_11_1 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_1 then
				arg_8_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_1)
				arg_8_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["10162ui_story"].transform.position).z)
				arg_8_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["10162ui_story"].transform.localEulerAngles = arg_8_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_1 and arg_8_1.time_ < 0 + var_11_1 + arg_11_0 then
				arg_8_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["10162ui_story"].transform.position).z)
				arg_8_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["10162ui_story"].transform.localEulerAngles = arg_8_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_11_2 = GameObjectTools.GetOrAddComponent(arg_8_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(true)
				end
			end

			local var_11_3 = arg_8_1.actors_["10162ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect10162ui_story == nil then
				arg_8_1.var_.characterEffect10162ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect10162ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_4)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect10162ui_story then
				arg_8_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_11_5 = 0
			local var_11_6 = 1.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_5 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_7 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325581002).content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_9 = 45 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 45)

				if (45 <= 0 and var_11_6 or var_11_6 * (utf8.len(var_11_7) / 45)) > 0 and var_11_6 < var_11_9 then
					arg_8_1.talkMaxDuration = var_11_9

					if var_11_9 + var_11_5 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_9 + var_11_5
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_10 = math.max(var_11_6, arg_8_1.talkMaxDuration)

			if var_11_5 <= arg_8_1.time_ and arg_8_1.time_ < var_11_5 + var_11_10 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_5) / var_11_10

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_5 + var_11_10 and arg_8_1.time_ < var_11_5 + var_11_10 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play325581003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325581003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325581004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.275

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325581003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 51 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 51)

				if (51 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 51)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325581004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325581004
		arg_16_1.duration_ = 6.2

		local var_16_0 = {
			zh = 3.4,
			ja = 6.2
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325581005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10162ui_story = arg_16_1.actors_["10162ui_story"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10162ui_story"].transform.position).z)
				arg_16_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["10162ui_story"].transform.localEulerAngles = arg_16_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["10162ui_story"].transform.position).z)
				arg_16_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["10162ui_story"].transform.localEulerAngles = arg_16_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["10162ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect10162ui_story == nil then
				arg_16_1.var_.characterEffect10162ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect10162ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect10162ui_story then
				arg_16_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_6 = 0
			local var_19_7 = 0.375

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1533].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_8 = arg_16_1:GetWordFromCfg(325581004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 15 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 15)

				if (15 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 15)) > 0 and var_19_7 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581004", "story_v_out_325581.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_325581", "325581004", "story_v_out_325581.awb") / 1000

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end

					if var_19_8.prefab_name ~= "" and arg_16_1.actors_[var_19_8.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_8.prefab_name].transform, "story_v_out_325581", "325581004", "story_v_out_325581.awb")

						arg_16_1:RecordAudio("325581004", var_19_13)
						arg_16_1:RecordAudio("325581004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325581", "325581004", "story_v_out_325581.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325581", "325581004", "story_v_out_325581.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325581005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325581005
		arg_20_1.duration_ = 7.3

		local var_20_0 = {
			zh = 7.3,
			ja = 6.533
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325581006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10162ui_story = arg_20_1.actors_["10162ui_story"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10162ui_story, Vector3.New(0, -1.08, -5.83), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10162ui_story"].transform.position).z)
				arg_20_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["10162ui_story"].transform.localEulerAngles = arg_20_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_20_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10162ui_story"].transform.position).z)
				arg_20_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["10162ui_story"].transform.localEulerAngles = arg_20_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = arg_20_1.actors_["10162ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect10162ui_story == nil then
				arg_20_1.var_.characterEffect10162ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect10162ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect10162ui_story then
				arg_20_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_23_6 = 0
			local var_23_7 = 0.55

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(325581005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 22 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 22)

				if (22 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 22)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581005", "story_v_out_325581.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_out_325581", "325581005", "story_v_out_325581.awb") / 1000

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_325581", "325581005", "story_v_out_325581.awb")

						arg_20_1:RecordAudio("325581005", var_23_13)
						arg_20_1:RecordAudio("325581005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_325581", "325581005", "story_v_out_325581.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_325581", "325581005", "story_v_out_325581.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play325581006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325581006
		arg_24_1.duration_ = 11.6

		local var_24_0 = {
			zh = 8.766,
			ja = 11.6
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325581007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action4312")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_0 = 0
			local var_27_1 = 0.925

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(325581006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 37 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 37)

				if (37 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 37)) > 0 and var_27_1 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581006", "story_v_out_325581.awb") ~= 0 then
					local var_27_6 = manager.audio:GetVoiceLength("story_v_out_325581", "325581006", "story_v_out_325581.awb") / 1000

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end

					if var_27_2.prefab_name ~= "" and arg_24_1.actors_[var_27_2.prefab_name] ~= nil then
						local var_27_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_2.prefab_name].transform, "story_v_out_325581", "325581006", "story_v_out_325581.awb")

						arg_24_1:RecordAudio("325581006", var_27_7)
						arg_24_1:RecordAudio("325581006", var_27_7)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325581", "325581006", "story_v_out_325581.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325581", "325581006", "story_v_out_325581.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_8 and arg_24_1.time_ < var_27_0 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play325581007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325581007
		arg_28_1.duration_ = 7.63

		local var_28_0 = {
			zh = 5.1,
			ja = 7.633
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325581008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10162ui_story"]) and arg_28_1.var_.characterEffect10162ui_story == nil then
				arg_28_1.var_.characterEffect10162ui_story = arg_28_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10162ui_story"]) then
				if arg_28_1.var_.characterEffect10162ui_story and not isNil(arg_28_1.actors_["10162ui_story"]) then
					arg_28_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10162ui_story"]) and arg_28_1.var_.characterEffect10162ui_story then
				arg_28_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.5

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1533].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(325581007)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 20 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 20)

				if (20 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 20)) > 0 and var_31_2 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581007", "story_v_out_325581.awb") ~= 0 then
					local var_31_7 = manager.audio:GetVoiceLength("story_v_out_325581", "325581007", "story_v_out_325581.awb") / 1000

					if var_31_7 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_1
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_325581", "325581007", "story_v_out_325581.awb")

						arg_28_1:RecordAudio("325581007", var_31_8)
						arg_28_1:RecordAudio("325581007", var_31_8)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_325581", "325581007", "story_v_out_325581.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_325581", "325581007", "story_v_out_325581.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_9 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_9

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_9 and arg_28_1.time_ < var_31_1 + var_31_9 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play325581008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325581008
		arg_32_1.duration_ = 8.5

		local var_32_0 = {
			zh = 6.466,
			ja = 8.5
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325581009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10162ui_story"]) and arg_32_1.var_.characterEffect10162ui_story == nil then
				arg_32_1.var_.characterEffect10162ui_story = arg_32_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10162ui_story"]) then
				if arg_32_1.var_.characterEffect10162ui_story and not isNil(arg_32_1.actors_["10162ui_story"]) then
					arg_32_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10162ui_story"]) and arg_32_1.var_.characterEffect10162ui_story then
				arg_32_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_2 = 0
			local var_35_3 = 0.525

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(325581008)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 21 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 21)

				if (21 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 21)) > 0 and var_35_3 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581008", "story_v_out_325581.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_325581", "325581008", "story_v_out_325581.awb") / 1000

					if var_35_8 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_2
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_325581", "325581008", "story_v_out_325581.awb")

						arg_32_1:RecordAudio("325581008", var_35_9)
						arg_32_1:RecordAudio("325581008", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_325581", "325581008", "story_v_out_325581.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_325581", "325581008", "story_v_out_325581.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_10 and arg_32_1.time_ < var_35_2 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325581009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325581009
		arg_36_1.duration_ = 11

		local var_36_0 = {
			zh = 9.1,
			ja = 11
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325581010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10162ui_story = arg_36_1.actors_["10162ui_story"].transform.localPosition

				local var_39_0 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_0 then
					var_39_0:EnableDynamicBone(false)
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10162ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_36_1.time_ - 0) / var_39_1)
				arg_36_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10162ui_story"].transform.position).z)
				arg_36_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["10162ui_story"].transform.localEulerAngles = arg_36_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				arg_36_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["10162ui_story"].transform.position).z)
				arg_36_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["10162ui_story"].transform.localEulerAngles = arg_36_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_39_2 = GameObjectTools.GetOrAddComponent(arg_36_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(true)
				end
			end

			local var_39_3 = "10166ui_story"

			if arg_36_1.actors_["10166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10166ui_story"))) then
				local var_39_4 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_36_1.stage_.transform)

				var_39_4.name = var_39_3
				var_39_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_[var_39_3] = var_39_4

				local var_39_5 = var_39_4:GetComponentInChildren(typeof(CharacterEffect))

				var_39_5.enabled = true

				local var_39_6 = GameObjectTools.GetOrAddComponent(var_39_4, typeof(DynamicBoneHelper))

				if var_39_6 then
					var_39_6:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_5.transform, false)

				arg_36_1.var_[var_39_3 .. "Animator"] = var_39_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_[var_39_3 .. "Animator"].applyRootMotion = true
				arg_36_1.var_[var_39_3 .. "LipSync"] = var_39_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_7 = arg_36_1.actors_["10166ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10166ui_story = var_39_7.localPosition

				local var_39_8 = GameObjectTools.GetOrAddComponent(var_39_7.gameObject, typeof(DynamicBoneHelper))

				if var_39_8 then
					var_39_8:EnableDynamicBone(false)
				end
			end

			local var_39_9 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_9 then
				var_39_7.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10166ui_story, Vector3.New(0.7, -1.28, -5.73), (arg_36_1.time_ - 0) / var_39_9)
				var_39_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_7.position).x, (manager.ui.mainCamera.transform.position - var_39_7.position).y, (manager.ui.mainCamera.transform.position - var_39_7.position).z)
				var_39_7.localEulerAngles.z = 0
				var_39_7.localEulerAngles.x = 0
				var_39_7.localEulerAngles = var_39_7.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_9 and arg_36_1.time_ < 0 + var_39_9 + arg_39_0 then
				var_39_7.localPosition = Vector3.New(0.7, -1.28, -5.73)
				var_39_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_7.position).x, (manager.ui.mainCamera.transform.position - var_39_7.position).y, (manager.ui.mainCamera.transform.position - var_39_7.position).z)
				var_39_7.localEulerAngles.z = 0
				var_39_7.localEulerAngles.x = 0
				var_39_7.localEulerAngles = var_39_7.localEulerAngles

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_7.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["10166ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect10166ui_story == nil then
				arg_36_1.var_.characterEffect10166ui_story = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_12 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_12 and not isNil(var_39_11) then
				if arg_36_1.var_.characterEffect10166ui_story and not isNil(var_39_11) then
					arg_36_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_12 and arg_36_1.time_ < 0 + var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect10166ui_story then
				arg_36_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_39_14 = arg_36_1.actors_["10162ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect10162ui_story == nil then
				arg_36_1.var_.characterEffect10162ui_story = var_39_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_15 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_15 and not isNil(var_39_14) then
				if arg_36_1.var_.characterEffect10162ui_story and not isNil(var_39_14) then
					arg_36_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_15)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_15 and arg_36_1.time_ < 0 + var_39_15 + arg_39_0 and not isNil(var_39_14) and arg_36_1.var_.characterEffect10162ui_story then
				arg_36_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_16 = 0
			local var_39_17 = 0.95

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_18 = arg_36_1:GetWordFromCfg(325581009)
				local var_39_19 = arg_36_1:FormatText(var_39_18.content)

				arg_36_1.text_.text = var_39_19

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 38 <= 0 and var_39_17 or var_39_17 * (utf8.len(var_39_19) / 38)

				if (38 <= 0 and var_39_17 or var_39_17 * (utf8.len(var_39_19) / 38)) > 0 and var_39_17 < var_39_21 then
					arg_36_1.talkMaxDuration = var_39_21

					if var_39_21 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_21 + var_39_16
					end
				end

				arg_36_1.text_.text = var_39_19
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581009", "story_v_out_325581.awb") ~= 0 then
					local var_39_22 = manager.audio:GetVoiceLength("story_v_out_325581", "325581009", "story_v_out_325581.awb") / 1000

					if var_39_22 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_22 + var_39_16
					end

					if var_39_18.prefab_name ~= "" and arg_36_1.actors_[var_39_18.prefab_name] ~= nil then
						local var_39_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_18.prefab_name].transform, "story_v_out_325581", "325581009", "story_v_out_325581.awb")

						arg_36_1:RecordAudio("325581009", var_39_23)
						arg_36_1:RecordAudio("325581009", var_39_23)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325581", "325581009", "story_v_out_325581.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325581", "325581009", "story_v_out_325581.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_24 = math.max(var_39_17, arg_36_1.talkMaxDuration)

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_24 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_16) / var_39_24

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_16 + var_39_24 and arg_36_1.time_ < var_39_16 + var_39_24 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325581010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 325581010
		arg_40_1.duration_ = 4.53

		local var_40_0 = {
			zh = 4.533,
			ja = 3.366
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play325581011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10166ui_story"]) and arg_40_1.var_.characterEffect10166ui_story == nil then
				arg_40_1.var_.characterEffect10166ui_story = arg_40_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10166ui_story"]) then
				if arg_40_1.var_.characterEffect10166ui_story and not isNil(arg_40_1.actors_["10166ui_story"]) then
					arg_40_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10166ui_story"]) and arg_40_1.var_.characterEffect10166ui_story then
				arg_40_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.5

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1533].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(325581010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 20 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 20)

				if (20 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 20)) > 0 and var_43_2 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581010", "story_v_out_325581.awb") ~= 0 then
					local var_43_7 = manager.audio:GetVoiceLength("story_v_out_325581", "325581010", "story_v_out_325581.awb") / 1000

					if var_43_7 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_1
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_325581", "325581010", "story_v_out_325581.awb")

						arg_40_1:RecordAudio("325581010", var_43_8)
						arg_40_1:RecordAudio("325581010", var_43_8)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_325581", "325581010", "story_v_out_325581.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_325581", "325581010", "story_v_out_325581.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_9 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_9 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_9

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_9 and arg_40_1.time_ < var_43_1 + var_43_9 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play325581011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 325581011
		arg_44_1.duration_ = 8.43

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play325581012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["10166ui_story"]) and arg_44_1.var_.characterEffect10166ui_story == nil then
				arg_44_1.var_.characterEffect10166ui_story = arg_44_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["10166ui_story"]) then
				if arg_44_1.var_.characterEffect10166ui_story and not isNil(arg_44_1.actors_["10166ui_story"]) then
					arg_44_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["10166ui_story"]) and arg_44_1.var_.characterEffect10166ui_story then
				arg_44_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_47_2 = 0
			local var_47_3 = 1

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(325581011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 40 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 40)

				if (40 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 40)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581011", "story_v_out_325581.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_325581", "325581011", "story_v_out_325581.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_325581", "325581011", "story_v_out_325581.awb")

						arg_44_1:RecordAudio("325581011", var_47_9)
						arg_44_1:RecordAudio("325581011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_325581", "325581011", "story_v_out_325581.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_325581", "325581011", "story_v_out_325581.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play325581012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325581012
		arg_48_1.duration_ = 10

		local var_48_0 = {
			zh = 7.6,
			ja = 10
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325581013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10166ui_story"]) and arg_48_1.var_.characterEffect10166ui_story == nil then
				arg_48_1.var_.characterEffect10166ui_story = arg_48_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10166ui_story"]) then
				if arg_48_1.var_.characterEffect10166ui_story and not isNil(arg_48_1.actors_["10166ui_story"]) then
					arg_48_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10166ui_story"]) and arg_48_1.var_.characterEffect10166ui_story then
				arg_48_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.95

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1533].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(325581012)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 38 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 38)

				if (38 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_4) / 38)) > 0 and var_51_2 < var_51_6 then
					arg_48_1.talkMaxDuration = var_51_6

					if var_51_6 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581012", "story_v_out_325581.awb") ~= 0 then
					local var_51_7 = manager.audio:GetVoiceLength("story_v_out_325581", "325581012", "story_v_out_325581.awb") / 1000

					if var_51_7 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_1
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_325581", "325581012", "story_v_out_325581.awb")

						arg_48_1:RecordAudio("325581012", var_51_8)
						arg_48_1:RecordAudio("325581012", var_51_8)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_325581", "325581012", "story_v_out_325581.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_325581", "325581012", "story_v_out_325581.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_9 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_9 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_9

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_9 and arg_48_1.time_ < var_51_1 + var_51_9 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325581013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325581013
		arg_52_1.duration_ = 5.77

		local var_52_0 = {
			zh = 4.666,
			ja = 5.766
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325581014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10166ui_story"]) and arg_52_1.var_.characterEffect10166ui_story == nil then
				arg_52_1.var_.characterEffect10166ui_story = arg_52_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10166ui_story"]) then
				if arg_52_1.var_.characterEffect10166ui_story and not isNil(arg_52_1.actors_["10166ui_story"]) then
					arg_52_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10166ui_story"]) and arg_52_1.var_.characterEffect10166ui_story then
				arg_52_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_55_2 = 0
			local var_55_3 = 0.5

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(325581013)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 20 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 20)

				if (20 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 20)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581013", "story_v_out_325581.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_325581", "325581013", "story_v_out_325581.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_325581", "325581013", "story_v_out_325581.awb")

						arg_52_1:RecordAudio("325581013", var_55_9)
						arg_52_1:RecordAudio("325581013", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_325581", "325581013", "story_v_out_325581.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_325581", "325581013", "story_v_out_325581.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_10 and arg_52_1.time_ < var_55_2 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325581014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325581014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325581015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10166ui_story = arg_56_1.actors_["10166ui_story"].transform.localPosition

				local var_59_0 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_0 then
					var_59_0:EnableDynamicBone(false)
				end
			end

			local var_59_1 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				arg_56_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_1)
				arg_56_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10166ui_story"].transform.position).z)
				arg_56_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10166ui_story"].transform.localEulerAngles = arg_56_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				arg_56_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10166ui_story"].transform.position).z)
				arg_56_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10166ui_story"].transform.localEulerAngles = arg_56_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_59_2 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(true)
				end
			end

			local var_59_3 = arg_56_1.actors_["10162ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10162ui_story = var_59_3.localPosition

				local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_4 then
					var_59_4:EnableDynamicBone(false)
				end
			end

			local var_59_5 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 then
				var_59_3.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_5)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 then
				var_59_3.localPosition = Vector3.New(0, 100, 0)
				var_59_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_3.position).x, (manager.ui.mainCamera.transform.position - var_59_3.position).y, (manager.ui.mainCamera.transform.position - var_59_3.position).z)
				var_59_3.localEulerAngles.z = 0
				var_59_3.localEulerAngles.x = 0
				var_59_3.localEulerAngles = var_59_3.localEulerAngles

				local var_59_6 = GameObjectTools.GetOrAddComponent(var_59_3.gameObject, typeof(DynamicBoneHelper))

				if var_59_6 then
					var_59_6:EnableDynamicBone(true)
				end
			end

			local var_59_7 = arg_56_1.actors_["10166ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.characterEffect10166ui_story == nil then
				arg_56_1.var_.characterEffect10166ui_story = var_59_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_8 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_8 and not isNil(var_59_7) then
				if arg_56_1.var_.characterEffect10166ui_story and not isNil(var_59_7) then
					arg_56_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_8)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_8 and arg_56_1.time_ < 0 + var_59_8 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.characterEffect10166ui_story then
				arg_56_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_59_9 = 0
			local var_59_10 = 0.65

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_11 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(325581014).content)

				arg_56_1.text_.text = var_59_11

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_13 = 26 <= 0 and var_59_10 or var_59_10 * (utf8.len(var_59_11) / 26)

				if (26 <= 0 and var_59_10 or var_59_10 * (utf8.len(var_59_11) / 26)) > 0 and var_59_10 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_9 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_9
					end
				end

				arg_56_1.text_.text = var_59_11
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_10, arg_56_1.talkMaxDuration)

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_9) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_9 + var_59_14 and arg_56_1.time_ < var_59_9 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play325581015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325581015
		arg_60_1.duration_ = 10.87

		local var_60_0 = {
			zh = 10.866,
			ja = 9.233
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325581016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10166ui_story = arg_60_1.actors_["10166ui_story"].transform.localPosition

				local var_63_0 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_0 then
					var_63_0:EnableDynamicBone(false)
				end
			end

			local var_63_1 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 then
				arg_60_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10166ui_story, Vector3.New(0, -1.28, -5.73), (arg_60_1.time_ - 0) / var_63_1)
				arg_60_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10166ui_story"].transform.position).z)
				arg_60_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10166ui_story"].transform.localEulerAngles = arg_60_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 then
				arg_60_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.73)
				arg_60_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10166ui_story"].transform.position).z)
				arg_60_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10166ui_story"].transform.localEulerAngles = arg_60_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_63_2 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(true)
				end
			end

			local var_63_3 = arg_60_1.actors_["10166ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect10166ui_story == nil then
				arg_60_1.var_.characterEffect10166ui_story = var_63_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_4 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 and not isNil(var_63_3) then
				if arg_60_1.var_.characterEffect10166ui_story and not isNil(var_63_3) then
					arg_60_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect10166ui_story then
				arg_60_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			local var_63_6 = 0
			local var_63_7 = 1.075

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_8 = arg_60_1:GetWordFromCfg(325581015)
				local var_63_9 = arg_60_1:FormatText(var_63_8.content)

				arg_60_1.text_.text = var_63_9

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_11 = 43 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_9) / 43)

				if (43 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_9) / 43)) > 0 and var_63_7 < var_63_11 then
					arg_60_1.talkMaxDuration = var_63_11

					if var_63_11 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_9
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581015", "story_v_out_325581.awb") ~= 0 then
					local var_63_12 = manager.audio:GetVoiceLength("story_v_out_325581", "325581015", "story_v_out_325581.awb") / 1000

					if var_63_12 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_6
					end

					if var_63_8.prefab_name ~= "" and arg_60_1.actors_[var_63_8.prefab_name] ~= nil then
						local var_63_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_8.prefab_name].transform, "story_v_out_325581", "325581015", "story_v_out_325581.awb")

						arg_60_1:RecordAudio("325581015", var_63_13)
						arg_60_1:RecordAudio("325581015", var_63_13)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325581", "325581015", "story_v_out_325581.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325581", "325581015", "story_v_out_325581.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_14 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_14 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_14

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_14 and arg_60_1.time_ < var_63_6 + var_63_14 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play325581016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325581016
		arg_64_1.duration_ = 6.97

		local var_64_0 = {
			zh = 4.3,
			ja = 6.966
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325581017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10166ui_story = arg_64_1.actors_["10166ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10166ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10166ui_story"].transform.position).z)
				arg_64_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10166ui_story"].transform.localEulerAngles = arg_64_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_64_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10166ui_story"].transform.position).z)
				arg_64_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10166ui_story"].transform.localEulerAngles = arg_64_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = arg_64_1.actors_["10162ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10162ui_story = var_67_3.localPosition

				local var_67_4 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_4 then
					var_67_4:EnableDynamicBone(false)
				end
			end

			local var_67_5 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_3.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10162ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_64_1.time_ - 0) / var_67_5)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_3.localPosition = Vector3.New(0.7, -1.08, -5.83)
				var_67_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_3.position).x, (manager.ui.mainCamera.transform.position - var_67_3.position).y, (manager.ui.mainCamera.transform.position - var_67_3.position).z)
				var_67_3.localEulerAngles.z = 0
				var_67_3.localEulerAngles.x = 0
				var_67_3.localEulerAngles = var_67_3.localEulerAngles

				local var_67_6 = GameObjectTools.GetOrAddComponent(var_67_3.gameObject, typeof(DynamicBoneHelper))

				if var_67_6 then
					var_67_6:EnableDynamicBone(true)
				end
			end

			local var_67_7 = arg_64_1.actors_["10162ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect10162ui_story == nil then
				arg_64_1.var_.characterEffect10162ui_story = var_67_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_8 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_8 and not isNil(var_67_7) then
				if arg_64_1.var_.characterEffect10162ui_story and not isNil(var_67_7) then
					arg_64_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_8 and arg_64_1.time_ < 0 + var_67_8 + arg_67_0 and not isNil(var_67_7) and arg_64_1.var_.characterEffect10162ui_story then
				arg_64_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_67_10 = arg_64_1.actors_["10166ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect10166ui_story == nil then
				arg_64_1.var_.characterEffect10166ui_story = var_67_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_11 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_11 and not isNil(var_67_10) then
				if arg_64_1.var_.characterEffect10166ui_story and not isNil(var_67_10) then
					arg_64_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_11)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_11 and arg_64_1.time_ < 0 + var_67_11 + arg_67_0 and not isNil(var_67_10) and arg_64_1.var_.characterEffect10166ui_story then
				arg_64_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_67_12 = 0
			local var_67_13 = 0.525

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(325581016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 21 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 21)

				if (21 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 21)) > 0 and var_67_13 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_12
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581016", "story_v_out_325581.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_325581", "325581016", "story_v_out_325581.awb") / 1000

					if var_67_18 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_12
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_325581", "325581016", "story_v_out_325581.awb")

						arg_64_1:RecordAudio("325581016", var_67_19)
						arg_64_1:RecordAudio("325581016", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_325581", "325581016", "story_v_out_325581.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_325581", "325581016", "story_v_out_325581.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_13, arg_64_1.talkMaxDuration)

			if var_67_12 <= arg_64_1.time_ and arg_64_1.time_ < var_67_12 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_12) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_12 + var_67_20 and arg_64_1.time_ < var_67_12 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play325581017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 325581017
		arg_68_1.duration_ = 5.2

		local var_68_0 = {
			zh = 4.733,
			ja = 5.2
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play325581018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10166ui_story"]) and arg_68_1.var_.characterEffect10166ui_story == nil then
				arg_68_1.var_.characterEffect10166ui_story = arg_68_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10166ui_story"]) then
				if arg_68_1.var_.characterEffect10166ui_story and not isNil(arg_68_1.actors_["10166ui_story"]) then
					arg_68_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10166ui_story"]) and arg_68_1.var_.characterEffect10166ui_story then
				arg_68_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["10162ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect10162ui_story == nil then
				arg_68_1.var_.characterEffect10162ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect10162ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_68_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect10162ui_story then
				arg_68_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_68_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_71_4 = 0
			local var_71_5 = 0.45

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(325581017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 18 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 18)

				if (18 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 18)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581017", "story_v_out_325581.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_325581", "325581017", "story_v_out_325581.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_325581", "325581017", "story_v_out_325581.awb")

						arg_68_1:RecordAudio("325581017", var_71_11)
						arg_68_1:RecordAudio("325581017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_325581", "325581017", "story_v_out_325581.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_325581", "325581017", "story_v_out_325581.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play325581018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 325581018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play325581019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10166ui_story = arg_72_1.actors_["10166ui_story"].transform.localPosition

				local var_75_0 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_0 then
					var_75_0:EnableDynamicBone(false)
				end
			end

			local var_75_1 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				arg_72_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_1)
				arg_72_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10166ui_story"].transform.position).z)
				arg_72_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["10166ui_story"].transform.localEulerAngles = arg_72_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 then
				arg_72_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10166ui_story"].transform.position).z)
				arg_72_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["10166ui_story"].transform.localEulerAngles = arg_72_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_75_2 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(true)
				end
			end

			local var_75_3 = arg_72_1.actors_["10162ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10162ui_story = var_75_3.localPosition

				local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_3.gameObject, typeof(DynamicBoneHelper))

				if var_75_4 then
					var_75_4:EnableDynamicBone(false)
				end
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_3.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_5)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_3.localPosition = Vector3.New(0, 100, 0)
				var_75_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_3.position).x, (manager.ui.mainCamera.transform.position - var_75_3.position).y, (manager.ui.mainCamera.transform.position - var_75_3.position).z)
				var_75_3.localEulerAngles.z = 0
				var_75_3.localEulerAngles.x = 0
				var_75_3.localEulerAngles = var_75_3.localEulerAngles

				local var_75_6 = GameObjectTools.GetOrAddComponent(var_75_3.gameObject, typeof(DynamicBoneHelper))

				if var_75_6 then
					var_75_6:EnableDynamicBone(true)
				end
			end

			local var_75_7 = arg_72_1.actors_["10166ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect10166ui_story == nil then
				arg_72_1.var_.characterEffect10166ui_story = var_75_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_8 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_8 and not isNil(var_75_7) then
				if arg_72_1.var_.characterEffect10166ui_story and not isNil(var_75_7) then
					arg_72_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_8)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_8 and arg_72_1.time_ < 0 + var_75_8 + arg_75_0 and not isNil(var_75_7) and arg_72_1.var_.characterEffect10166ui_story then
				arg_72_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_75_9 = 0
			local var_75_10 = 1.2

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_11 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(325581018).content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 48 <= 0 and var_75_10 or var_75_10 * (utf8.len(var_75_11) / 48)

				if (48 <= 0 and var_75_10 or var_75_10 * (utf8.len(var_75_11) / 48)) > 0 and var_75_10 < var_75_13 then
					arg_72_1.talkMaxDuration = var_75_13

					if var_75_13 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_13 + var_75_9
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_10, arg_72_1.talkMaxDuration)

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_9) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_9 + var_75_14 and arg_72_1.time_ < var_75_9 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play325581019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 325581019
		arg_76_1.duration_ = 3.47

		local var_76_0 = {
			zh = 3.233,
			ja = 3.466
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play325581020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10166ui_story = arg_76_1.actors_["10166ui_story"].transform.localPosition

				local var_79_0 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_0 then
					var_79_0:EnableDynamicBone(false)
				end
			end

			local var_79_1 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 then
				arg_76_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10166ui_story, Vector3.New(0, -1.28, -5.73), (arg_76_1.time_ - 0) / var_79_1)
				arg_76_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).z)
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles = arg_76_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 then
				arg_76_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.73)
				arg_76_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10166ui_story"].transform.position).z)
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10166ui_story"].transform.localEulerAngles = arg_76_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_79_2 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(true)
				end
			end

			local var_79_3 = arg_76_1.actors_["10166ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect10166ui_story == nil then
				arg_76_1.var_.characterEffect10166ui_story = var_79_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_4 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 and not isNil(var_79_3) then
				if arg_76_1.var_.characterEffect10166ui_story and not isNil(var_79_3) then
					arg_76_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect10166ui_story then
				arg_76_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_79_6 = 0
			local var_79_7 = 0.375

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(325581019)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 15 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 15)

				if (15 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 15)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581019", "story_v_out_325581.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_325581", "325581019", "story_v_out_325581.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_325581", "325581019", "story_v_out_325581.awb")

						arg_76_1:RecordAudio("325581019", var_79_13)
						arg_76_1:RecordAudio("325581019", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_325581", "325581019", "story_v_out_325581.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_325581", "325581019", "story_v_out_325581.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = math.max(var_79_7, arg_76_1.talkMaxDuration)

			if var_79_6 <= arg_76_1.time_ and arg_76_1.time_ < var_79_6 + var_79_14 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_6) / var_79_14

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_6 + var_79_14 and arg_76_1.time_ < var_79_6 + var_79_14 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play325581020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 325581020
		arg_80_1.duration_ = 4.27

		local var_80_0 = {
			zh = 4.066,
			ja = 4.266
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play325581021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10166ui_story = arg_80_1.actors_["10166ui_story"].transform.localPosition

				local var_83_0 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_0 then
					var_83_0:EnableDynamicBone(false)
				end
			end

			local var_83_1 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_1 then
				arg_80_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10166ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_80_1.time_ - 0) / var_83_1)
				arg_80_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10166ui_story"].transform.position).z)
				arg_80_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["10166ui_story"].transform.localEulerAngles = arg_80_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_1 and arg_80_1.time_ < 0 + var_83_1 + arg_83_0 then
				arg_80_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_80_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["10166ui_story"].transform.position).z)
				arg_80_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["10166ui_story"].transform.localEulerAngles = arg_80_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_83_2 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(true)
				end
			end

			local var_83_3 = arg_80_1.actors_["10162ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10162ui_story = var_83_3.localPosition

				local var_83_4 = GameObjectTools.GetOrAddComponent(var_83_3.gameObject, typeof(DynamicBoneHelper))

				if var_83_4 then
					var_83_4:EnableDynamicBone(false)
				end
			end

			local var_83_5 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_5 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10162ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_80_1.time_ - 0) / var_83_5)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_5 and arg_80_1.time_ < 0 + var_83_5 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(0.7, -1.08, -5.83)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles

				local var_83_6 = GameObjectTools.GetOrAddComponent(var_83_3.gameObject, typeof(DynamicBoneHelper))

				if var_83_6 then
					var_83_6:EnableDynamicBone(true)
				end
			end

			local var_83_7 = arg_80_1.actors_["10162ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_7) and arg_80_1.var_.characterEffect10162ui_story == nil then
				arg_80_1.var_.characterEffect10162ui_story = var_83_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_8 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_8 and not isNil(var_83_7) then
				if arg_80_1.var_.characterEffect10162ui_story and not isNil(var_83_7) then
					arg_80_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_8 and arg_80_1.time_ < 0 + var_83_8 + arg_83_0 and not isNil(var_83_7) and arg_80_1.var_.characterEffect10162ui_story then
				arg_80_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_83_10 = arg_80_1.actors_["10166ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_10) and arg_80_1.var_.characterEffect10166ui_story == nil then
				arg_80_1.var_.characterEffect10166ui_story = var_83_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_11 and not isNil(var_83_10) then
				if arg_80_1.var_.characterEffect10166ui_story and not isNil(var_83_10) then
					arg_80_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_80_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_11)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_11 and arg_80_1.time_ < 0 + var_83_11 + arg_83_0 and not isNil(var_83_10) and arg_80_1.var_.characterEffect10166ui_story then
				arg_80_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_80_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_83_12 = 0
			local var_83_13 = 0.4

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_12 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_14 = arg_80_1:GetWordFromCfg(325581020)
				local var_83_15 = arg_80_1:FormatText(var_83_14.content)

				arg_80_1.text_.text = var_83_15

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_17 = 16 <= 0 and var_83_13 or var_83_13 * (utf8.len(var_83_15) / 16)

				if (16 <= 0 and var_83_13 or var_83_13 * (utf8.len(var_83_15) / 16)) > 0 and var_83_13 < var_83_17 then
					arg_80_1.talkMaxDuration = var_83_17

					if var_83_17 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_12
					end
				end

				arg_80_1.text_.text = var_83_15
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581020", "story_v_out_325581.awb") ~= 0 then
					local var_83_18 = manager.audio:GetVoiceLength("story_v_out_325581", "325581020", "story_v_out_325581.awb") / 1000

					if var_83_18 + var_83_12 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_12
					end

					if var_83_14.prefab_name ~= "" and arg_80_1.actors_[var_83_14.prefab_name] ~= nil then
						local var_83_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_14.prefab_name].transform, "story_v_out_325581", "325581020", "story_v_out_325581.awb")

						arg_80_1:RecordAudio("325581020", var_83_19)
						arg_80_1:RecordAudio("325581020", var_83_19)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_325581", "325581020", "story_v_out_325581.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_325581", "325581020", "story_v_out_325581.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_20 = math.max(var_83_13, arg_80_1.talkMaxDuration)

			if var_83_12 <= arg_80_1.time_ and arg_80_1.time_ < var_83_12 + var_83_20 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_12) / var_83_20

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_12 + var_83_20 and arg_80_1.time_ < var_83_12 + var_83_20 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play325581021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 325581021
		arg_84_1.duration_ = 14.33

		local var_84_0 = {
			zh = 9.466,
			ja = 14.333
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play325581022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.775

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1532].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:GetWordFromCfg(325581021)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 31 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 31)

				if (31 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 31)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581021", "story_v_out_325581.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_325581", "325581021", "story_v_out_325581.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_325581", "325581021", "story_v_out_325581.awb")

						arg_84_1:RecordAudio("325581021", var_87_6)
						arg_84_1:RecordAudio("325581021", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_325581", "325581021", "story_v_out_325581.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_325581", "325581021", "story_v_out_325581.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play325581022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 325581022
		arg_88_1.duration_ = 5.73

		local var_88_0 = {
			zh = 5.733,
			ja = 3.2
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play325581023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["10166ui_story"]) and arg_88_1.var_.characterEffect10166ui_story == nil then
				arg_88_1.var_.characterEffect10166ui_story = arg_88_1.actors_["10166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["10166ui_story"]) then
				if arg_88_1.var_.characterEffect10166ui_story and not isNil(arg_88_1.actors_["10166ui_story"]) then
					arg_88_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["10166ui_story"]) and arg_88_1.var_.characterEffect10166ui_story then
				arg_88_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_91_2 = arg_88_1.actors_["10162ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect10162ui_story == nil then
				arg_88_1.var_.characterEffect10162ui_story = var_91_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.characterEffect10162ui_story and not isNil(var_91_2) then
					arg_88_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_3)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect10162ui_story then
				arg_88_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action16_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_91_4 = 0
			local var_91_5 = 0.55

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(325581022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 22 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 22)

				if (22 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 22)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581022", "story_v_out_325581.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_325581", "325581022", "story_v_out_325581.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_325581", "325581022", "story_v_out_325581.awb")

						arg_88_1:RecordAudio("325581022", var_91_11)
						arg_88_1:RecordAudio("325581022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_325581", "325581022", "story_v_out_325581.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_325581", "325581022", "story_v_out_325581.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play325581023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325581023
		arg_92_1.duration_ = 10.23

		local var_92_0 = {
			zh = 5.733,
			ja = 10.233
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325581024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.675

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:GetWordFromCfg(325581023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 27 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 27)

				if (27 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 27)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581023", "story_v_out_325581.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_325581", "325581023", "story_v_out_325581.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_325581", "325581023", "story_v_out_325581.awb")

						arg_92_1:RecordAudio("325581023", var_95_6)
						arg_92_1:RecordAudio("325581023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325581", "325581023", "story_v_out_325581.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325581", "325581023", "story_v_out_325581.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play325581024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 325581024
		arg_96_1.duration_ = 9

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play325581025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if arg_96_1.bgs_.J26h == nil then
				local var_99_0 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J26h")
				var_99_0.name = "J26h"
				var_99_0.transform.parent = arg_96_1.stage_.transform
				var_99_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_.J26h = var_99_0
			end

			if 2 < arg_96_1.time_ and arg_96_1.time_ <= 2 + arg_99_0 then
				local var_99_1 = arg_96_1.bgs_.J26h

				arg_96_1.bgs_.J26h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_99_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_2 = var_99_1:GetComponent("SpriteRenderer")

				if var_99_2 and var_99_2.sprite then
					local var_99_3 = 2 * (var_99_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_99_1.transform.localScale = Vector3.New(var_99_3 / var_99_2.sprite.bounds.size.y < var_99_3 * manager.ui.mainCameraCom_.aspect / var_99_2.sprite.bounds.size.x and var_99_3 * manager.ui.mainCameraCom_.aspect / var_99_2.sprite.bounds.size.x or var_99_3 / var_99_2.sprite.bounds.size.y, var_99_3 / var_99_2.sprite.bounds.size.y < var_99_3 * manager.ui.mainCameraCom_.aspect / var_99_2.sprite.bounds.size.x and var_99_3 * manager.ui.mainCameraCom_.aspect / var_99_2.sprite.bounds.size.x or var_99_3 / var_99_2.sprite.bounds.size.y, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "J26h" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_4 = 3.999999999999

			if 3.999999999999 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			if arg_96_1.time_ >= var_99_4 + 0.3 and arg_96_1.time_ < var_99_4 + 0.3 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			local var_99_5 = 0

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_6 = 2

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 then
				local var_99_7 = Color.New(0, 0, 0)

				var_99_7.a = Mathf.Lerp(0, 1, (arg_96_1.time_ - var_99_5) / var_99_6)
				arg_96_1.mask_.color = var_99_7
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 then
				local var_99_8 = Color.New(0, 0, 0)

				var_99_8.a = 1
				arg_96_1.mask_.color = var_99_8
			end

			local var_99_9 = 2

			if 2 < arg_96_1.time_ and arg_96_1.time_ <= var_99_9 + arg_99_0 then
				arg_96_1.mask_.enabled = true
				arg_96_1.mask_.raycastTarget = true

				arg_96_1:SetGaussion(false)
			end

			local var_99_10 = 2

			if var_99_9 <= arg_96_1.time_ and arg_96_1.time_ < var_99_9 + var_99_10 then
				local var_99_11 = Color.New(0, 0, 0)

				var_99_11.a = Mathf.Lerp(1, 0, (arg_96_1.time_ - var_99_9) / var_99_10)
				arg_96_1.mask_.color = var_99_11
			end

			if arg_96_1.time_ >= var_99_9 + var_99_10 and arg_96_1.time_ < var_99_9 + var_99_10 + arg_99_0 then
				local var_99_12 = Color.New(0, 0, 0)

				arg_96_1.mask_.enabled = false
				var_99_12.a = 0
				arg_96_1.mask_.color = var_99_12
			end

			local var_99_13 = arg_96_1.actors_["10166ui_story"].transform

			if 1.96599999815226 < arg_96_1.time_ and arg_96_1.time_ <= 1.96599999815226 + arg_99_0 then
				arg_96_1.var_.moveOldPos10166ui_story = var_99_13.localPosition

				local var_99_14 = GameObjectTools.GetOrAddComponent(var_99_13.gameObject, typeof(DynamicBoneHelper))

				if var_99_14 then
					var_99_14:EnableDynamicBone(false)
				end
			end

			local var_99_15 = 0.001

			if 1.96599999815226 <= arg_96_1.time_ and arg_96_1.time_ < 1.96599999815226 + var_99_15 then
				var_99_13.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 1.96599999815226) / var_99_15)
				var_99_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_13.position).x, (manager.ui.mainCamera.transform.position - var_99_13.position).y, (manager.ui.mainCamera.transform.position - var_99_13.position).z)
				var_99_13.localEulerAngles.z = 0
				var_99_13.localEulerAngles.x = 0
				var_99_13.localEulerAngles = var_99_13.localEulerAngles
			end

			if arg_96_1.time_ >= 1.96599999815226 + var_99_15 and arg_96_1.time_ < 1.96599999815226 + var_99_15 + arg_99_0 then
				var_99_13.localPosition = Vector3.New(0, 100, 0)
				var_99_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_13.position).x, (manager.ui.mainCamera.transform.position - var_99_13.position).y, (manager.ui.mainCamera.transform.position - var_99_13.position).z)
				var_99_13.localEulerAngles.z = 0
				var_99_13.localEulerAngles.x = 0
				var_99_13.localEulerAngles = var_99_13.localEulerAngles

				local var_99_16 = GameObjectTools.GetOrAddComponent(var_99_13.gameObject, typeof(DynamicBoneHelper))

				if var_99_16 then
					var_99_16:EnableDynamicBone(true)
				end
			end

			local var_99_17 = arg_96_1.actors_["10162ui_story"].transform

			if 1.96599999815226 < arg_96_1.time_ and arg_96_1.time_ <= 1.96599999815226 + arg_99_0 then
				arg_96_1.var_.moveOldPos10162ui_story = var_99_17.localPosition

				local var_99_18 = GameObjectTools.GetOrAddComponent(var_99_17.gameObject, typeof(DynamicBoneHelper))

				if var_99_18 then
					var_99_18:EnableDynamicBone(false)
				end
			end

			local var_99_19 = 0.001

			if 1.96599999815226 <= arg_96_1.time_ and arg_96_1.time_ < 1.96599999815226 + var_99_19 then
				var_99_17.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 1.96599999815226) / var_99_19)
				var_99_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_17.position).x, (manager.ui.mainCamera.transform.position - var_99_17.position).y, (manager.ui.mainCamera.transform.position - var_99_17.position).z)
				var_99_17.localEulerAngles.z = 0
				var_99_17.localEulerAngles.x = 0
				var_99_17.localEulerAngles = var_99_17.localEulerAngles
			end

			if arg_96_1.time_ >= 1.96599999815226 + var_99_19 and arg_96_1.time_ < 1.96599999815226 + var_99_19 + arg_99_0 then
				var_99_17.localPosition = Vector3.New(0, 100, 0)
				var_99_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_17.position).x, (manager.ui.mainCamera.transform.position - var_99_17.position).y, (manager.ui.mainCamera.transform.position - var_99_17.position).z)
				var_99_17.localEulerAngles.z = 0
				var_99_17.localEulerAngles.x = 0
				var_99_17.localEulerAngles = var_99_17.localEulerAngles

				local var_99_20 = GameObjectTools.GetOrAddComponent(var_99_17.gameObject, typeof(DynamicBoneHelper))

				if var_99_20 then
					var_99_20:EnableDynamicBone(true)
				end
			end

			local var_99_21 = arg_96_1.actors_["10166ui_story"]

			if 1.96599999815226 < arg_96_1.time_ and arg_96_1.time_ <= 1.96599999815226 + arg_99_0 and not isNil(var_99_21) and arg_96_1.var_.characterEffect10166ui_story == nil then
				arg_96_1.var_.characterEffect10166ui_story = var_99_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_22 = 0.034000001847744

			if 1.96599999815226 <= arg_96_1.time_ and arg_96_1.time_ < 1.96599999815226 + var_99_22 and not isNil(var_99_21) then
				if arg_96_1.var_.characterEffect10166ui_story and not isNil(var_99_21) then
					arg_96_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 1.96599999815226) / var_99_22)
				end
			end

			if arg_96_1.time_ >= 1.96599999815226 + var_99_22 and arg_96_1.time_ < 1.96599999815226 + var_99_22 + arg_99_0 and not isNil(var_99_21) and arg_96_1.var_.characterEffect10166ui_story then
				arg_96_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_99_23 = arg_96_1.bgs_.J26h.transform

			if 2 < arg_96_1.time_ and arg_96_1.time_ <= 2 + arg_99_0 then
				arg_96_1.var_.moveOldPosJ26h = var_99_23.localPosition
			end

			local var_99_24 = 2.4

			if 2 <= arg_96_1.time_ and arg_96_1.time_ < 2 + var_99_24 then
				var_99_23.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPosJ26h, Vector3.New(0, 1, 9.5), (arg_96_1.time_ - 2) / var_99_24)
			end

			if arg_96_1.time_ >= 2 + var_99_24 and arg_96_1.time_ < 2 + var_99_24 + arg_99_0 then
				var_99_23.localPosition = Vector3.New(0, 1, 9.5)
			end

			if arg_96_1.frameCnt_ <= 1 then
				arg_96_1.dialog_:SetActive(false)
			end

			local var_99_25 = 3.999999999999
			local var_99_26 = 1.675

			if 3.999999999999 < arg_96_1.time_ and arg_96_1.time_ <= var_99_25 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0

				arg_96_1.dialog_:SetActive(true)

				arg_96_1.dialogCg_.alpha = 0

				local var_99_27 = LeanTween.value(arg_96_1.dialog_, 0, 1, 0.3)

				var_99_27:setOnUpdate(LuaHelper.FloatAction(function(arg_100_0)
					arg_96_1.dialogCg_.alpha = arg_100_0
				end))
				var_99_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_96_1.dialog_)
					var_99_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_96_1.duration_ = arg_96_1.duration_ + 0.3

				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_28 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(325581024).content)

				arg_96_1.text_.text = var_99_28

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_30 = 67 <= 0 and var_99_26 or var_99_26 * (utf8.len(var_99_28) / 67)

				if (67 <= 0 and var_99_26 or var_99_26 * (utf8.len(var_99_28) / 67)) > 0 and var_99_26 < var_99_30 then
					arg_96_1.talkMaxDuration = var_99_30
					var_99_25 = var_99_25 + 0.3

					if var_99_30 + var_99_25 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_30 + var_99_25
					end
				end

				arg_96_1.text_.text = var_99_28
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_31 = var_99_25 + 0.3
			local var_99_32 = math.max(var_99_26, arg_96_1.talkMaxDuration)

			if var_99_25 + 0.3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_31 + var_99_32 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_31) / var_99_32

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_31 + var_99_32 and arg_96_1.time_ < var_99_31 + var_99_32 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J26h",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.4,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play325581025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325581025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325581026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 1.075

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(325581025).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 43 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 43)

				if (43 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 43)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325581026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325581026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325581027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 1.375

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(325581026).content)

				arg_106_1.text_.text = var_109_1

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_3 = 55 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 55)

				if (55 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 55)) > 0 and var_109_0 < var_109_3 then
					arg_106_1.talkMaxDuration = var_109_3

					if var_109_3 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_3 + 0
					end
				end

				arg_106_1.text_.text = var_109_1
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_4 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_4

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play325581027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325581027
		arg_110_1.duration_ = 4.57

		local var_110_0 = {
			zh = 3.9,
			ja = 4.566
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325581028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.actors_["10167ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10167ui_story"))) then
				local var_113_0 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_110_1.stage_.transform)

				var_113_0.name = "10167ui_story"
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_["10167ui_story"] = var_113_0

				local var_113_1 = var_113_0:GetComponentInChildren(typeof(CharacterEffect))

				var_113_1.enabled = true

				local var_113_2 = GameObjectTools.GetOrAddComponent(var_113_0, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(false)
				end

				arg_110_1:ShowWeapon(var_113_1.transform, false)

				arg_110_1.var_["10167ui_story" .. "Animator"] = var_113_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_110_1.var_["10167ui_story" .. "Animator"].applyRootMotion = true
				arg_110_1.var_["10167ui_story" .. "LipSync"] = var_113_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_113_3 = arg_110_1.actors_["10167ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10167ui_story = var_113_3.localPosition

				local var_113_4 = GameObjectTools.GetOrAddComponent(var_113_3.gameObject, typeof(DynamicBoneHelper))

				if var_113_4 then
					var_113_4:EnableDynamicBone(false)
				end
			end

			local var_113_5 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_5 then
				var_113_3.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10167ui_story, Vector3.New(0, -1.28, -5.73), (arg_110_1.time_ - 0) / var_113_5)
				var_113_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_3.position).x, (manager.ui.mainCamera.transform.position - var_113_3.position).y, (manager.ui.mainCamera.transform.position - var_113_3.position).z)
				var_113_3.localEulerAngles.z = 0
				var_113_3.localEulerAngles.x = 0
				var_113_3.localEulerAngles = var_113_3.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_5 and arg_110_1.time_ < 0 + var_113_5 + arg_113_0 then
				var_113_3.localPosition = Vector3.New(0, -1.28, -5.73)
				var_113_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_3.position).x, (manager.ui.mainCamera.transform.position - var_113_3.position).y, (manager.ui.mainCamera.transform.position - var_113_3.position).z)
				var_113_3.localEulerAngles.z = 0
				var_113_3.localEulerAngles.x = 0
				var_113_3.localEulerAngles = var_113_3.localEulerAngles

				local var_113_6 = GameObjectTools.GetOrAddComponent(var_113_3.gameObject, typeof(DynamicBoneHelper))

				if var_113_6 then
					var_113_6:EnableDynamicBone(true)
				end
			end

			local var_113_7 = arg_110_1.actors_["10167ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_7) and arg_110_1.var_.characterEffect10167ui_story == nil then
				arg_110_1.var_.characterEffect10167ui_story = var_113_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_8 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_8 and not isNil(var_113_7) then
				if arg_110_1.var_.characterEffect10167ui_story and not isNil(var_113_7) then
					arg_110_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_8 and arg_110_1.time_ < 0 + var_113_8 + arg_113_0 and not isNil(var_113_7) and arg_110_1.var_.characterEffect10167ui_story then
				arg_110_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_113_10 = 0
			local var_113_11 = 0.425

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_12 = arg_110_1:GetWordFromCfg(325581027)
				local var_113_13 = arg_110_1:FormatText(var_113_12.content)

				arg_110_1.text_.text = var_113_13

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_15 = 17 <= 0 and var_113_11 or var_113_11 * (utf8.len(var_113_13) / 17)

				if (17 <= 0 and var_113_11 or var_113_11 * (utf8.len(var_113_13) / 17)) > 0 and var_113_11 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_10
					end
				end

				arg_110_1.text_.text = var_113_13
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581027", "story_v_out_325581.awb") ~= 0 then
					local var_113_16 = manager.audio:GetVoiceLength("story_v_out_325581", "325581027", "story_v_out_325581.awb") / 1000

					if var_113_16 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_16 + var_113_10
					end

					if var_113_12.prefab_name ~= "" and arg_110_1.actors_[var_113_12.prefab_name] ~= nil then
						local var_113_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_12.prefab_name].transform, "story_v_out_325581", "325581027", "story_v_out_325581.awb")

						arg_110_1:RecordAudio("325581027", var_113_17)
						arg_110_1:RecordAudio("325581027", var_113_17)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_325581", "325581027", "story_v_out_325581.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_325581", "325581027", "story_v_out_325581.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_18 = math.max(var_113_11, arg_110_1.talkMaxDuration)

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_18 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_10) / var_113_18

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_10 + var_113_18 and arg_110_1.time_ < var_113_10 + var_113_18 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play325581028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325581028
		arg_114_1.duration_ = 3.57

		local var_114_0 = {
			zh = 1.999999999999,
			ja = 3.566
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325581029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos10167ui_story = arg_114_1.actors_["10167ui_story"].transform.localPosition

				local var_117_0 = GameObjectTools.GetOrAddComponent(arg_114_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_117_0 then
					var_117_0:EnableDynamicBone(false)
				end
			end

			local var_117_1 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_1 then
				arg_114_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10167ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_114_1.time_ - 0) / var_117_1)
				arg_114_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10167ui_story"].transform.position).z)
				arg_114_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["10167ui_story"].transform.localEulerAngles = arg_114_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_1 and arg_114_1.time_ < 0 + var_117_1 + arg_117_0 then
				arg_114_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_114_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["10167ui_story"].transform.position).z)
				arg_114_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["10167ui_story"].transform.localEulerAngles = arg_114_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_117_2 = GameObjectTools.GetOrAddComponent(arg_114_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(true)
				end
			end

			local var_117_3 = "10175ui_story"

			if arg_114_1.actors_["10175ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10175ui_story"))) then
				local var_117_4 = Object.Instantiate(Asset.Load("Char/" .. "10175ui_story"), arg_114_1.stage_.transform)

				var_117_4.name = var_117_3
				var_117_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.actors_[var_117_3] = var_117_4

				local var_117_5 = var_117_4:GetComponentInChildren(typeof(CharacterEffect))

				var_117_5.enabled = true

				local var_117_6 = GameObjectTools.GetOrAddComponent(var_117_4, typeof(DynamicBoneHelper))

				if var_117_6 then
					var_117_6:EnableDynamicBone(false)
				end

				arg_114_1:ShowWeapon(var_117_5.transform, false)

				arg_114_1.var_[var_117_3 .. "Animator"] = var_117_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_114_1.var_[var_117_3 .. "Animator"].applyRootMotion = true
				arg_114_1.var_[var_117_3 .. "LipSync"] = var_117_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_117_7 = arg_114_1.actors_["10175ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos10175ui_story = var_117_7.localPosition

				local var_117_8 = GameObjectTools.GetOrAddComponent(var_117_7.gameObject, typeof(DynamicBoneHelper))

				if var_117_8 then
					var_117_8:EnableDynamicBone(false)
				end
			end

			local var_117_9 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_9 then
				var_117_7.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10175ui_story, Vector3.New(0.7, -1, -6.05), (arg_114_1.time_ - 0) / var_117_9)
				var_117_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_7.position).x, (manager.ui.mainCamera.transform.position - var_117_7.position).y, (manager.ui.mainCamera.transform.position - var_117_7.position).z)
				var_117_7.localEulerAngles.z = 0
				var_117_7.localEulerAngles.x = 0
				var_117_7.localEulerAngles = var_117_7.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_9 and arg_114_1.time_ < 0 + var_117_9 + arg_117_0 then
				var_117_7.localPosition = Vector3.New(0.7, -1, -6.05)
				var_117_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_7.position).x, (manager.ui.mainCamera.transform.position - var_117_7.position).y, (manager.ui.mainCamera.transform.position - var_117_7.position).z)
				var_117_7.localEulerAngles.z = 0
				var_117_7.localEulerAngles.x = 0
				var_117_7.localEulerAngles = var_117_7.localEulerAngles

				local var_117_10 = GameObjectTools.GetOrAddComponent(var_117_7.gameObject, typeof(DynamicBoneHelper))

				if var_117_10 then
					var_117_10:EnableDynamicBone(true)
				end
			end

			local var_117_11 = arg_114_1.actors_["10175ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_11) and arg_114_1.var_.characterEffect10175ui_story == nil then
				arg_114_1.var_.characterEffect10175ui_story = var_117_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_12 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_12 and not isNil(var_117_11) then
				if arg_114_1.var_.characterEffect10175ui_story and not isNil(var_117_11) then
					arg_114_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_12 and arg_114_1.time_ < 0 + var_117_12 + arg_117_0 and not isNil(var_117_11) and arg_114_1.var_.characterEffect10175ui_story then
				arg_114_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_117_14 = arg_114_1.actors_["10167ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_14) and arg_114_1.var_.characterEffect10167ui_story == nil then
				arg_114_1.var_.characterEffect10167ui_story = var_117_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_15 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_15 and not isNil(var_117_14) then
				if arg_114_1.var_.characterEffect10167ui_story and not isNil(var_117_14) then
					arg_114_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_114_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_15)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_15 and arg_114_1.time_ < 0 + var_117_15 + arg_117_0 and not isNil(var_117_14) and arg_114_1.var_.characterEffect10167ui_story then
				arg_114_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_114_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_117_16 = 0
			local var_117_17 = 0.2

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_18 = arg_114_1:GetWordFromCfg(325581028)
				local var_117_19 = arg_114_1:FormatText(var_117_18.content)

				arg_114_1.text_.text = var_117_19

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_21 = 8 <= 0 and var_117_17 or var_117_17 * (utf8.len(var_117_19) / 8)

				if (8 <= 0 and var_117_17 or var_117_17 * (utf8.len(var_117_19) / 8)) > 0 and var_117_17 < var_117_21 then
					arg_114_1.talkMaxDuration = var_117_21

					if var_117_21 + var_117_16 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_21 + var_117_16
					end
				end

				arg_114_1.text_.text = var_117_19
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581028", "story_v_out_325581.awb") ~= 0 then
					local var_117_22 = manager.audio:GetVoiceLength("story_v_out_325581", "325581028", "story_v_out_325581.awb") / 1000

					if var_117_22 + var_117_16 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_22 + var_117_16
					end

					if var_117_18.prefab_name ~= "" and arg_114_1.actors_[var_117_18.prefab_name] ~= nil then
						local var_117_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_18.prefab_name].transform, "story_v_out_325581", "325581028", "story_v_out_325581.awb")

						arg_114_1:RecordAudio("325581028", var_117_23)
						arg_114_1:RecordAudio("325581028", var_117_23)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325581", "325581028", "story_v_out_325581.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325581", "325581028", "story_v_out_325581.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_24 = math.max(var_117_17, arg_114_1.talkMaxDuration)

			if var_117_16 <= arg_114_1.time_ and arg_114_1.time_ < var_117_16 + var_117_24 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_16) / var_117_24

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_16 + var_117_24 and arg_114_1.time_ < var_117_16 + var_117_24 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play325581029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325581029
		arg_118_1.duration_ = 7.8

		local var_118_0 = {
			zh = 6,
			ja = 7.8
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325581030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["10167ui_story"]) and arg_118_1.var_.characterEffect10167ui_story == nil then
				arg_118_1.var_.characterEffect10167ui_story = arg_118_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["10167ui_story"]) then
				if arg_118_1.var_.characterEffect10167ui_story and not isNil(arg_118_1.actors_["10167ui_story"]) then
					arg_118_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["10167ui_story"]) and arg_118_1.var_.characterEffect10167ui_story then
				arg_118_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["10175ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect10175ui_story == nil then
				arg_118_1.var_.characterEffect10175ui_story = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_3 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.characterEffect10175ui_story and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_118_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_3)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect10175ui_story then
				arg_118_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_118_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_121_4 = 0
			local var_121_5 = 0.65

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(325581029)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 26 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 26)

				if (26 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 26)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581029", "story_v_out_325581.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_325581", "325581029", "story_v_out_325581.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_325581", "325581029", "story_v_out_325581.awb")

						arg_118_1:RecordAudio("325581029", var_121_11)
						arg_118_1:RecordAudio("325581029", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325581", "325581029", "story_v_out_325581.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325581", "325581029", "story_v_out_325581.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325581030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325581030
		arg_122_1.duration_ = 6.2

		local var_122_0 = {
			zh = 5.1,
			ja = 6.2
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325581031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["10175ui_story"]) and arg_122_1.var_.characterEffect10175ui_story == nil then
				arg_122_1.var_.characterEffect10175ui_story = arg_122_1.actors_["10175ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["10175ui_story"]) then
				if arg_122_1.var_.characterEffect10175ui_story and not isNil(arg_122_1.actors_["10175ui_story"]) then
					arg_122_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["10175ui_story"]) and arg_122_1.var_.characterEffect10175ui_story then
				arg_122_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["10167ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect10167ui_story == nil then
				arg_122_1.var_.characterEffect10167ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect10167ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_122_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect10167ui_story then
				arg_122_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_122_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_125_4 = 0
			local var_125_5 = 0.6

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(325581030)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 24 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 24)

				if (24 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 24)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581030", "story_v_out_325581.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_325581", "325581030", "story_v_out_325581.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_out_325581", "325581030", "story_v_out_325581.awb")

						arg_122_1:RecordAudio("325581030", var_125_11)
						arg_122_1:RecordAudio("325581030", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_325581", "325581030", "story_v_out_325581.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_325581", "325581030", "story_v_out_325581.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325581031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325581031
		arg_126_1.duration_ = 4.27

		local var_126_0 = {
			zh = 3.3,
			ja = 4.266
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325581032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10175ui_story = arg_126_1.actors_["10175ui_story"].transform.localPosition

				local var_129_0 = GameObjectTools.GetOrAddComponent(arg_126_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_129_0 then
					var_129_0:EnableDynamicBone(false)
				end
			end

			local var_129_1 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_1 then
				arg_126_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_1)
				arg_126_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10175ui_story"].transform.position).z)
				arg_126_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["10175ui_story"].transform.localEulerAngles = arg_126_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_1 and arg_126_1.time_ < 0 + var_129_1 + arg_129_0 then
				arg_126_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["10175ui_story"].transform.position).z)
				arg_126_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["10175ui_story"].transform.localEulerAngles = arg_126_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_129_2 = GameObjectTools.GetOrAddComponent(arg_126_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_129_2 then
					var_129_2:EnableDynamicBone(true)
				end
			end

			local var_129_3 = "10176ui_story"

			if arg_126_1.actors_["10176ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10176ui_story"))) then
				local var_129_4 = Object.Instantiate(Asset.Load("Char/" .. "10176ui_story"), arg_126_1.stage_.transform)

				var_129_4.name = var_129_3
				var_129_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_[var_129_3] = var_129_4

				local var_129_5 = var_129_4:GetComponentInChildren(typeof(CharacterEffect))

				var_129_5.enabled = true

				local var_129_6 = GameObjectTools.GetOrAddComponent(var_129_4, typeof(DynamicBoneHelper))

				if var_129_6 then
					var_129_6:EnableDynamicBone(false)
				end

				arg_126_1:ShowWeapon(var_129_5.transform, false)

				arg_126_1.var_[var_129_3 .. "Animator"] = var_129_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_126_1.var_[var_129_3 .. "Animator"].applyRootMotion = true
				arg_126_1.var_[var_129_3 .. "LipSync"] = var_129_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_129_7 = arg_126_1.actors_["10176ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10176ui_story = var_129_7.localPosition

				local var_129_8 = GameObjectTools.GetOrAddComponent(var_129_7.gameObject, typeof(DynamicBoneHelper))

				if var_129_8 then
					var_129_8:EnableDynamicBone(false)
				end
			end

			local var_129_9 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_9 then
				var_129_7.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10176ui_story, Vector3.New(-0.02, -1.09, -6.12), (arg_126_1.time_ - 0) / var_129_9)
				var_129_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_7.position).x, (manager.ui.mainCamera.transform.position - var_129_7.position).y, (manager.ui.mainCamera.transform.position - var_129_7.position).z)
				var_129_7.localEulerAngles.z = 0
				var_129_7.localEulerAngles.x = 0
				var_129_7.localEulerAngles = var_129_7.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_9 and arg_126_1.time_ < 0 + var_129_9 + arg_129_0 then
				var_129_7.localPosition = Vector3.New(-0.02, -1.09, -6.12)
				var_129_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_7.position).x, (manager.ui.mainCamera.transform.position - var_129_7.position).y, (manager.ui.mainCamera.transform.position - var_129_7.position).z)
				var_129_7.localEulerAngles.z = 0
				var_129_7.localEulerAngles.x = 0
				var_129_7.localEulerAngles = var_129_7.localEulerAngles

				local var_129_10 = GameObjectTools.GetOrAddComponent(var_129_7.gameObject, typeof(DynamicBoneHelper))

				if var_129_10 then
					var_129_10:EnableDynamicBone(true)
				end
			end

			local var_129_11 = arg_126_1.actors_["10167ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos10167ui_story = var_129_11.localPosition

				local var_129_12 = GameObjectTools.GetOrAddComponent(var_129_11.gameObject, typeof(DynamicBoneHelper))

				if var_129_12 then
					var_129_12:EnableDynamicBone(false)
				end
			end

			local var_129_13 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_13 then
				var_129_11.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_13)
				var_129_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_11.position).x, (manager.ui.mainCamera.transform.position - var_129_11.position).y, (manager.ui.mainCamera.transform.position - var_129_11.position).z)
				var_129_11.localEulerAngles.z = 0
				var_129_11.localEulerAngles.x = 0
				var_129_11.localEulerAngles = var_129_11.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_13 and arg_126_1.time_ < 0 + var_129_13 + arg_129_0 then
				var_129_11.localPosition = Vector3.New(0, 100, 0)
				var_129_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_11.position).x, (manager.ui.mainCamera.transform.position - var_129_11.position).y, (manager.ui.mainCamera.transform.position - var_129_11.position).z)
				var_129_11.localEulerAngles.z = 0
				var_129_11.localEulerAngles.x = 0
				var_129_11.localEulerAngles = var_129_11.localEulerAngles

				local var_129_14 = GameObjectTools.GetOrAddComponent(var_129_11.gameObject, typeof(DynamicBoneHelper))

				if var_129_14 then
					var_129_14:EnableDynamicBone(true)
				end
			end

			local var_129_15 = arg_126_1.actors_["10176ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_15) and arg_126_1.var_.characterEffect10176ui_story == nil then
				arg_126_1.var_.characterEffect10176ui_story = var_129_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_16 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_16 and not isNil(var_129_15) then
				if arg_126_1.var_.characterEffect10176ui_story and not isNil(var_129_15) then
					arg_126_1.var_.characterEffect10176ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_16 and arg_126_1.time_ < 0 + var_129_16 + arg_129_0 and not isNil(var_129_15) and arg_126_1.var_.characterEffect10176ui_story then
				arg_126_1.var_.characterEffect10176ui_story.fillFlat = false
			end

			local var_129_18 = arg_126_1.actors_["10175ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_18) and arg_126_1.var_.characterEffect10175ui_story == nil then
				arg_126_1.var_.characterEffect10175ui_story = var_129_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_19 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_19 and not isNil(var_129_18) then
				if arg_126_1.var_.characterEffect10175ui_story and not isNil(var_129_18) then
					arg_126_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_19)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_19 and arg_126_1.time_ < 0 + var_129_19 + arg_129_0 and not isNil(var_129_18) and arg_126_1.var_.characterEffect10175ui_story then
				arg_126_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/story10176/story10176action/10176action1_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10176ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_129_20 = 0
			local var_129_21 = 0.25

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_20 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1510].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_22 = arg_126_1:GetWordFromCfg(325581031)
				local var_129_23 = arg_126_1:FormatText(var_129_22.content)

				arg_126_1.text_.text = var_129_23

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_25 = 10 <= 0 and var_129_21 or var_129_21 * (utf8.len(var_129_23) / 10)

				if (10 <= 0 and var_129_21 or var_129_21 * (utf8.len(var_129_23) / 10)) > 0 and var_129_21 < var_129_25 then
					arg_126_1.talkMaxDuration = var_129_25

					if var_129_25 + var_129_20 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_25 + var_129_20
					end
				end

				arg_126_1.text_.text = var_129_23
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581031", "story_v_out_325581.awb") ~= 0 then
					local var_129_26 = manager.audio:GetVoiceLength("story_v_out_325581", "325581031", "story_v_out_325581.awb") / 1000

					if var_129_26 + var_129_20 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_26 + var_129_20
					end

					if var_129_22.prefab_name ~= "" and arg_126_1.actors_[var_129_22.prefab_name] ~= nil then
						local var_129_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_22.prefab_name].transform, "story_v_out_325581", "325581031", "story_v_out_325581.awb")

						arg_126_1:RecordAudio("325581031", var_129_27)
						arg_126_1:RecordAudio("325581031", var_129_27)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325581", "325581031", "story_v_out_325581.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325581", "325581031", "story_v_out_325581.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_28 = math.max(var_129_21, arg_126_1.talkMaxDuration)

			if var_129_20 <= arg_126_1.time_ and arg_126_1.time_ < var_129_20 + var_129_28 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_20) / var_129_28

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_20 + var_129_28 and arg_126_1.time_ < var_129_20 + var_129_28 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play325581032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325581032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325581033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10176ui_story = arg_130_1.actors_["10176ui_story"].transform.localPosition

				local var_133_0 = GameObjectTools.GetOrAddComponent(arg_130_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_133_0 then
					var_133_0:EnableDynamicBone(false)
				end
			end

			local var_133_1 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_1 then
				arg_130_1.actors_["10176ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10176ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_1)
				arg_130_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10176ui_story"].transform.position).z)
				arg_130_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["10176ui_story"].transform.localEulerAngles = arg_130_1.actors_["10176ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_1 and arg_130_1.time_ < 0 + var_133_1 + arg_133_0 then
				arg_130_1.actors_["10176ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_["10176ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["10176ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10176ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10176ui_story"].transform.position).z)
				arg_130_1.actors_["10176ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["10176ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["10176ui_story"].transform.localEulerAngles = arg_130_1.actors_["10176ui_story"].transform.localEulerAngles

				local var_133_2 = GameObjectTools.GetOrAddComponent(arg_130_1.actors_["10176ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(true)
				end
			end

			local var_133_3 = arg_130_1.actors_["10176ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect10176ui_story == nil then
				arg_130_1.var_.characterEffect10176ui_story = var_133_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_4 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 and not isNil(var_133_3) then
				if arg_130_1.var_.characterEffect10176ui_story and not isNil(var_133_3) then
					arg_130_1.var_.characterEffect10176ui_story.fillFlat = true
					arg_130_1.var_.characterEffect10176ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_4)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect10176ui_story then
				arg_130_1.var_.characterEffect10176ui_story.fillFlat = true
				arg_130_1.var_.characterEffect10176ui_story.fillRatio = 0.5
			end

			local var_133_5 = 0
			local var_133_6 = 1.875

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(325581032).content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 75 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 75)

				if (75 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 75)) > 0 and var_133_6 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_10 and arg_130_1.time_ < var_133_5 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10176ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play325581033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325581033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325581034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.775

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_1 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(325581033).content)

				arg_134_1.text_.text = var_137_1

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_3 = 31 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 31)

				if (31 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 31)) > 0 and var_137_0 < var_137_3 then
					arg_134_1.talkMaxDuration = var_137_3

					if var_137_3 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_3 + 0
					end
				end

				arg_134_1.text_.text = var_137_1
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_4 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_4

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play325581034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325581034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325581035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.55

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_1 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(325581034).content)

				arg_138_1.text_.text = var_141_1

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_3 = 22 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 22)

				if (22 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 22)) > 0 and var_141_0 < var_141_3 then
					arg_138_1.talkMaxDuration = var_141_3

					if var_141_3 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_3 + 0
					end
				end

				arg_138_1.text_.text = var_141_1
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_4 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_4

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play325581035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325581035
		arg_142_1.duration_ = 7.23

		local var_142_0 = {
			zh = 6.433,
			ja = 7.233
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play325581036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10175ui_story = arg_142_1.actors_["10175ui_story"].transform.localPosition

				local var_145_0 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_0 then
					var_145_0:EnableDynamicBone(false)
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_142_1.time_ - 0) / var_145_1)
				arg_142_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10175ui_story"].transform.position).z)
				arg_142_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["10175ui_story"].transform.localEulerAngles = arg_142_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_142_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10175ui_story"].transform.position).z)
				arg_142_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["10175ui_story"].transform.localEulerAngles = arg_142_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_145_2 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(true)
				end
			end

			local var_145_3 = arg_142_1.actors_["10175ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect10175ui_story == nil then
				arg_142_1.var_.characterEffect10175ui_story = var_145_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_4 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 and not isNil(var_145_3) then
				if arg_142_1.var_.characterEffect10175ui_story and not isNil(var_145_3) then
					arg_142_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect10175ui_story then
				arg_142_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action1_1")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_145_6 = 0
			local var_145_7 = 0.65

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_6 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_8 = arg_142_1:GetWordFromCfg(325581035)
				local var_145_9 = arg_142_1:FormatText(var_145_8.content)

				arg_142_1.text_.text = var_145_9

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_11 = 26 <= 0 and var_145_7 or var_145_7 * (utf8.len(var_145_9) / 26)

				if (26 <= 0 and var_145_7 or var_145_7 * (utf8.len(var_145_9) / 26)) > 0 and var_145_7 < var_145_11 then
					arg_142_1.talkMaxDuration = var_145_11

					if var_145_11 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_11 + var_145_6
					end
				end

				arg_142_1.text_.text = var_145_9
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581035", "story_v_out_325581.awb") ~= 0 then
					local var_145_12 = manager.audio:GetVoiceLength("story_v_out_325581", "325581035", "story_v_out_325581.awb") / 1000

					if var_145_12 + var_145_6 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_12 + var_145_6
					end

					if var_145_8.prefab_name ~= "" and arg_142_1.actors_[var_145_8.prefab_name] ~= nil then
						local var_145_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_8.prefab_name].transform, "story_v_out_325581", "325581035", "story_v_out_325581.awb")

						arg_142_1:RecordAudio("325581035", var_145_13)
						arg_142_1:RecordAudio("325581035", var_145_13)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_325581", "325581035", "story_v_out_325581.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_325581", "325581035", "story_v_out_325581.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_14 = math.max(var_145_7, arg_142_1.talkMaxDuration)

			if var_145_6 <= arg_142_1.time_ and arg_142_1.time_ < var_145_6 + var_145_14 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_6) / var_145_14

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_6 + var_145_14 and arg_142_1.time_ < var_145_6 + var_145_14 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play325581036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325581036
		arg_146_1.duration_ = 6

		local var_146_0 = {
			zh = 5.833,
			ja = 6
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325581037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.725

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:GetWordFromCfg(325581036)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 29 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 29)

				if (29 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 29)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581036", "story_v_out_325581.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_325581", "325581036", "story_v_out_325581.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_325581", "325581036", "story_v_out_325581.awb")

						arg_146_1:RecordAudio("325581036", var_149_6)
						arg_146_1:RecordAudio("325581036", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_325581", "325581036", "story_v_out_325581.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_325581", "325581036", "story_v_out_325581.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play325581037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325581037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play325581038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos10175ui_story = arg_150_1.actors_["10175ui_story"].transform.localPosition

				local var_153_0 = GameObjectTools.GetOrAddComponent(arg_150_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_153_0 then
					var_153_0:EnableDynamicBone(false)
				end
			end

			local var_153_1 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_1 then
				arg_150_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10175ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_1)
				arg_150_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10175ui_story"].transform.position).z)
				arg_150_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["10175ui_story"].transform.localEulerAngles = arg_150_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_1 and arg_150_1.time_ < 0 + var_153_1 + arg_153_0 then
				arg_150_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["10175ui_story"].transform.position).z)
				arg_150_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["10175ui_story"].transform.localEulerAngles = arg_150_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_153_2 = GameObjectTools.GetOrAddComponent(arg_150_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_153_2 then
					var_153_2:EnableDynamicBone(true)
				end
			end

			local var_153_3 = arg_150_1.actors_["10175ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_3) and arg_150_1.var_.characterEffect10175ui_story == nil then
				arg_150_1.var_.characterEffect10175ui_story = var_153_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_4 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 and not isNil(var_153_3) then
				if arg_150_1.var_.characterEffect10175ui_story and not isNil(var_153_3) then
					arg_150_1.var_.characterEffect10175ui_story.fillFlat = true
					arg_150_1.var_.characterEffect10175ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_4)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 and not isNil(var_153_3) and arg_150_1.var_.characterEffect10175ui_story then
				arg_150_1.var_.characterEffect10175ui_story.fillFlat = true
				arg_150_1.var_.characterEffect10175ui_story.fillRatio = 0.5
			end

			local var_153_5 = 0
			local var_153_6 = 1.275

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_7 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(325581037).content)

				arg_150_1.text_.text = var_153_7

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_9 = 51 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_7) / 51)

				if (51 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_7) / 51)) > 0 and var_153_6 < var_153_9 then
					arg_150_1.talkMaxDuration = var_153_9

					if var_153_9 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_9 + var_153_5
					end
				end

				arg_150_1.text_.text = var_153_7
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_6, arg_150_1.talkMaxDuration)

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_5) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_5 + var_153_10 and arg_150_1.time_ < var_153_5 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play325581038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325581038
		arg_154_1.duration_ = 5

		local var_154_0 = {
			zh = 4.8,
			ja = 5
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play325581039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos10175ui_story = arg_154_1.actors_["10175ui_story"].transform.localPosition

				local var_157_0 = GameObjectTools.GetOrAddComponent(arg_154_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_157_0 then
					var_157_0:EnableDynamicBone(false)
				end
			end

			local var_157_1 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_1 then
				arg_154_1.actors_["10175ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10175ui_story, Vector3.New(0, -1, -6.05), (arg_154_1.time_ - 0) / var_157_1)
				arg_154_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10175ui_story"].transform.position).z)
				arg_154_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["10175ui_story"].transform.localEulerAngles = arg_154_1.actors_["10175ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_1 and arg_154_1.time_ < 0 + var_157_1 + arg_157_0 then
				arg_154_1.actors_["10175ui_story"].transform.localPosition = Vector3.New(0, -1, -6.05)
				arg_154_1.actors_["10175ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["10175ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10175ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10175ui_story"].transform.position).z)
				arg_154_1.actors_["10175ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["10175ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["10175ui_story"].transform.localEulerAngles = arg_154_1.actors_["10175ui_story"].transform.localEulerAngles

				local var_157_2 = GameObjectTools.GetOrAddComponent(arg_154_1.actors_["10175ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(true)
				end
			end

			local var_157_3 = arg_154_1.actors_["10175ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect10175ui_story == nil then
				arg_154_1.var_.characterEffect10175ui_story = var_157_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_4 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 and not isNil(var_157_3) then
				if arg_154_1.var_.characterEffect10175ui_story and not isNil(var_157_3) then
					arg_154_1.var_.characterEffect10175ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 and not isNil(var_157_3) and arg_154_1.var_.characterEffect10175ui_story then
				arg_154_1.var_.characterEffect10175ui_story.fillFlat = false
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/story10175/story10175action/10175action39_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("10175ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_157_6 = 0
			local var_157_7 = 0.6

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_8 = arg_154_1:GetWordFromCfg(325581038)
				local var_157_9 = arg_154_1:FormatText(var_157_8.content)

				arg_154_1.text_.text = var_157_9

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 24 <= 0 and var_157_7 or var_157_7 * (utf8.len(var_157_9) / 24)

				if (24 <= 0 and var_157_7 or var_157_7 * (utf8.len(var_157_9) / 24)) > 0 and var_157_7 < var_157_11 then
					arg_154_1.talkMaxDuration = var_157_11

					if var_157_11 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_11 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_9
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581038", "story_v_out_325581.awb") ~= 0 then
					local var_157_12 = manager.audio:GetVoiceLength("story_v_out_325581", "325581038", "story_v_out_325581.awb") / 1000

					if var_157_12 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_12 + var_157_6
					end

					if var_157_8.prefab_name ~= "" and arg_154_1.actors_[var_157_8.prefab_name] ~= nil then
						local var_157_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_8.prefab_name].transform, "story_v_out_325581", "325581038", "story_v_out_325581.awb")

						arg_154_1:RecordAudio("325581038", var_157_13)
						arg_154_1:RecordAudio("325581038", var_157_13)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325581", "325581038", "story_v_out_325581.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325581", "325581038", "story_v_out_325581.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_14 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_14 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_14

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_14 and arg_154_1.time_ < var_157_6 + var_157_14 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10175ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play325581039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325581039
		arg_158_1.duration_ = 3.87

		local var_158_0 = {
			zh = 2.933,
			ja = 3.866
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
			arg_158_1.auto_ = false
		end

		function arg_158_1.playNext_(arg_160_0)
			arg_158_1.onStoryFinished_()
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_161_1 = 0
			local var_161_2 = 0.225

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1473].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:GetWordFromCfg(325581039)
				local var_161_4 = arg_158_1:FormatText(var_161_3.content)

				arg_158_1.text_.text = var_161_4

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_6 = 9 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_4) / 9)

				if (9 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_4) / 9)) > 0 and var_161_2 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_4
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325581", "325581039", "story_v_out_325581.awb") ~= 0 then
					local var_161_7 = manager.audio:GetVoiceLength("story_v_out_325581", "325581039", "story_v_out_325581.awb") / 1000

					if var_161_7 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_7 + var_161_1
					end

					if var_161_3.prefab_name ~= "" and arg_158_1.actors_[var_161_3.prefab_name] ~= nil then
						local var_161_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_3.prefab_name].transform, "story_v_out_325581", "325581039", "story_v_out_325581.awb")

						arg_158_1:RecordAudio("325581039", var_161_8)
						arg_158_1:RecordAudio("325581039", var_161_8)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_325581", "325581039", "story_v_out_325581.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_325581", "325581039", "story_v_out_325581.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_9 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_9 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_9

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_9 and arg_158_1.time_ < var_161_1 + var_161_9 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21h",
		"TextureConfig/Background/J26h"
	},
	voices = {
		"story_v_out_325581.awb"
	}
}
