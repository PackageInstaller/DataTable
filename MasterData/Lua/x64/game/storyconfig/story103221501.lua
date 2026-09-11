return {
	Play322151001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322151001
		arg_1_1.duration_ = 6.73

		local var_1_0 = {
			zh = 5.733,
			ja = 6.733
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322151002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L14f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L14f")
				var_4_0.name = "L14f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L14f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L14f

				arg_1_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L14f" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(322151001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 13 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 13)

				if (13 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 13)) > 0 and var_4_14 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_13 = var_4_13 + 0.3

					if var_4_19 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151001", "story_v_out_322151.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_out_322151", "322151001", "story_v_out_322151.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_out_322151", "322151001", "story_v_out_322151.awb")

						arg_1_1:RecordAudio("322151001", var_4_21)
						arg_1_1:RecordAudio("322151001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322151", "322151001", "story_v_out_322151.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322151", "322151001", "story_v_out_322151.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_13 + 0.3
			local var_4_23 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322151002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 322151002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play322151003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.175

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(322151002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 47 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 47)

				if (47 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 47)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play322151003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 322151003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play322151004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.275

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(322151003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 11 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 11)

				if (11 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 11)) > 0 and var_15_0 < var_15_3 then
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
	Play322151004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 322151004
		arg_16_1.duration_ = 5.13

		local var_16_0 = {
			zh = 2.966,
			ja = 5.133
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
				arg_16_0:Play322151005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "10104ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["10104ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["10104ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["10104ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["10104ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10104ui_story = var_19_3.localPosition
			end

			local var_19_4 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_16_1.time_ - 0) / var_19_4)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			local var_19_5 = arg_16_1.actors_["10104ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect10104ui_story == nil then
				arg_16_1.var_.characterEffect10104ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_6 and not isNil(var_19_5) then
				if arg_16_1.var_.characterEffect10104ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_6 and arg_16_1.time_ < 0 + var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect10104ui_story then
				arg_16_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_8 = 0
			local var_19_9 = 0.325

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(322151004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 13 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 13)

				if (13 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 13)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151004", "story_v_out_322151.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_322151", "322151004", "story_v_out_322151.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_322151", "322151004", "story_v_out_322151.awb")

						arg_16_1:RecordAudio("322151004", var_19_15)
						arg_16_1:RecordAudio("322151004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_322151", "322151004", "story_v_out_322151.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_322151", "322151004", "story_v_out_322151.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play322151005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 322151005
		arg_20_1.duration_ = 7.03

		local var_20_0 = {
			zh = 6.033,
			ja = 7.033
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
				arg_20_0:Play322151006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_23_0 = 0
			local var_23_1 = 0.7

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_2 = arg_20_1:GetWordFromCfg(322151005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 28 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 28)

				if (28 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 28)) > 0 and var_23_1 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151005", "story_v_out_322151.awb") ~= 0 then
					local var_23_6 = manager.audio:GetVoiceLength("story_v_out_322151", "322151005", "story_v_out_322151.awb") / 1000

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end

					if var_23_2.prefab_name ~= "" and arg_20_1.actors_[var_23_2.prefab_name] ~= nil then
						local var_23_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_2.prefab_name].transform, "story_v_out_322151", "322151005", "story_v_out_322151.awb")

						arg_20_1:RecordAudio("322151005", var_23_7)
						arg_20_1:RecordAudio("322151005", var_23_7)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_322151", "322151005", "story_v_out_322151.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_322151", "322151005", "story_v_out_322151.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play322151006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 322151006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play322151007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10104ui_story = arg_24_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_27_0 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				arg_24_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10104ui_story"].transform.position).z)
				arg_24_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["10104ui_story"].transform.localEulerAngles = arg_24_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				arg_24_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10104ui_story"].transform.position).z)
				arg_24_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["10104ui_story"].transform.localEulerAngles = arg_24_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_27_1 = arg_24_1.actors_["10104ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect10104ui_story == nil then
				arg_24_1.var_.characterEffect10104ui_story = var_27_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 and not isNil(var_27_1) then
				if arg_24_1.var_.characterEffect10104ui_story and not isNil(var_27_1) then
					arg_24_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_24_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_2)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect10104ui_story then
				arg_24_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_24_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_27_3 = 0
			local var_27_4 = 1.5

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_3 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_5 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(322151006).content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_7 = 60 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_5) / 60)

				if (60 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_5) / 60)) > 0 and var_27_4 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_3
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_8 = math.max(var_27_4, arg_24_1.talkMaxDuration)

			if var_27_3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_3 + var_27_8 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_3) / var_27_8

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_3 + var_27_8 and arg_24_1.time_ < var_27_3 + var_27_8 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play322151007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 322151007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play322151008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.85

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(322151007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 34 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 34)

				if (34 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 34)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play322151008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 322151008
		arg_32_1.duration_ = 3.5

		local var_32_0 = {
			zh = 2.1,
			ja = 3.5
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
				arg_32_0:Play322151009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10104ui_story = arg_32_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["10104ui_story"].transform.position).z)
				arg_32_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["10104ui_story"].transform.localEulerAngles = arg_32_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_32_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["10104ui_story"].transform.position).z)
				arg_32_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["10104ui_story"].transform.localEulerAngles = arg_32_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["10104ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect10104ui_story == nil then
				arg_32_1.var_.characterEffect10104ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 and not isNil(var_35_1) then
				if arg_32_1.var_.characterEffect10104ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect10104ui_story then
				arg_32_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_4 = 0
			local var_35_5 = 0.275

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(322151008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 11 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 11)

				if (11 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 11)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151008", "story_v_out_322151.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151008", "story_v_out_322151.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_322151", "322151008", "story_v_out_322151.awb")

						arg_32_1:RecordAudio("322151008", var_35_11)
						arg_32_1:RecordAudio("322151008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_322151", "322151008", "story_v_out_322151.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_322151", "322151008", "story_v_out_322151.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play322151009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 322151009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play322151010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["10104ui_story"]) and arg_36_1.var_.characterEffect10104ui_story == nil then
				arg_36_1.var_.characterEffect10104ui_story = arg_36_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["10104ui_story"]) then
				if arg_36_1.var_.characterEffect10104ui_story and not isNil(arg_36_1.actors_["10104ui_story"]) then
					arg_36_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_36_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["10104ui_story"]) and arg_36_1.var_.characterEffect10104ui_story then
				arg_36_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_36_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_39_1 = 0
			local var_39_2 = 0.425

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(322151009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 17 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 17)

				if (17 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 17)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play322151010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 322151010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play322151011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.875

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(322151010).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 35 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 35)

				if (35 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 35)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play322151011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 322151011
		arg_44_1.duration_ = 7.23

		local var_44_0 = {
			zh = 6.6,
			ja = 7.233
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play322151012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos10104ui_story = arg_44_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["10104ui_story"].transform.position).z)
				arg_44_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["10104ui_story"].transform.localEulerAngles = arg_44_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_44_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["10104ui_story"].transform.position).z)
				arg_44_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["10104ui_story"].transform.localEulerAngles = arg_44_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["10104ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect10104ui_story == nil then
				arg_44_1.var_.characterEffect10104ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect10104ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect10104ui_story then
				arg_44_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.575

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(322151011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 23 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 23)

				if (23 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 23)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151011", "story_v_out_322151.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151011", "story_v_out_322151.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_322151", "322151011", "story_v_out_322151.awb")

						arg_44_1:RecordAudio("322151011", var_47_11)
						arg_44_1:RecordAudio("322151011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_322151", "322151011", "story_v_out_322151.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_322151", "322151011", "story_v_out_322151.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play322151012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 322151012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play322151013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10104ui_story"]) and arg_48_1.var_.characterEffect10104ui_story == nil then
				arg_48_1.var_.characterEffect10104ui_story = arg_48_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10104ui_story"]) then
				if arg_48_1.var_.characterEffect10104ui_story and not isNil(arg_48_1.actors_["10104ui_story"]) then
					arg_48_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10104ui_story"]) and arg_48_1.var_.characterEffect10104ui_story then
				arg_48_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.6

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(322151012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 24 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 24)

				if (24 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 24)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play322151013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 322151013
		arg_52_1.duration_ = 5.93

		local var_52_0 = {
			zh = 5.932999999999,
			ja = 5.799999999999
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
				arg_52_0:Play322151014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.bgs_.L10g == nil then
				local var_55_0 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10g")
				var_55_0.name = "L10g"
				var_55_0.transform.parent = arg_52_1.stage_.transform
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_.L10g = var_55_0
			end

			if 2.00000000298023 < arg_52_1.time_ and arg_52_1.time_ <= 2.00000000298023 + arg_55_0 then
				local var_55_1 = arg_52_1.bgs_.L10g

				arg_52_1.bgs_.L10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_2 = var_55_1:GetComponent("SpriteRenderer")

				if var_55_2 and var_55_2.sprite then
					local var_55_3 = 2 * (var_55_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_1.transform.localScale = Vector3.New(var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, var_55_3 / var_55_2.sprite.bounds.size.y < var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x and var_55_3 * manager.ui.mainCameraCom_.aspect / var_55_2.sprite.bounds.size.x or var_55_3 / var_55_2.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "L10g" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_4 = 3.999999999999

			if 3.999999999999 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			if arg_52_1.time_ >= var_55_4 + 0.3 and arg_52_1.time_ < var_55_4 + 0.3 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end

			local var_55_5 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_6 = 2

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 then
				local var_55_7 = Color.New(0, 0, 0)

				var_55_7.a = Mathf.Lerp(0, 1, (arg_52_1.time_ - var_55_5) / var_55_6)
				arg_52_1.mask_.color = var_55_7
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 then
				local var_55_8 = Color.New(0, 0, 0)

				var_55_8.a = 1
				arg_52_1.mask_.color = var_55_8
			end

			local var_55_9 = 2

			if 2 < arg_52_1.time_ and arg_52_1.time_ <= var_55_9 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = true

				arg_52_1:SetGaussion(false)
			end

			local var_55_10 = 2

			if var_55_9 <= arg_52_1.time_ and arg_52_1.time_ < var_55_9 + var_55_10 then
				local var_55_11 = Color.New(0, 0, 0)

				var_55_11.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_9) / var_55_10)
				arg_52_1.mask_.color = var_55_11
			end

			if arg_52_1.time_ >= var_55_9 + var_55_10 and arg_52_1.time_ < var_55_9 + var_55_10 + arg_55_0 then
				local var_55_12 = Color.New(0, 0, 0)

				arg_52_1.mask_.enabled = false
				var_55_12.a = 0
				arg_52_1.mask_.color = var_55_12
			end

			local var_55_13 = arg_52_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_52_1.time_ and arg_52_1.time_ <= 1.96599999815226 + arg_55_0 then
				arg_52_1.var_.moveOldPos10104ui_story = var_55_13.localPosition
			end

			local var_55_14 = 0.001

			if 1.96599999815226 <= arg_52_1.time_ and arg_52_1.time_ < 1.96599999815226 + var_55_14 then
				var_55_13.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 1.96599999815226) / var_55_14)
				var_55_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_13.position).x, (manager.ui.mainCamera.transform.position - var_55_13.position).y, (manager.ui.mainCamera.transform.position - var_55_13.position).z)
				var_55_13.localEulerAngles.z = 0
				var_55_13.localEulerAngles.x = 0
				var_55_13.localEulerAngles = var_55_13.localEulerAngles
			end

			if arg_52_1.time_ >= 1.96599999815226 + var_55_14 and arg_52_1.time_ < 1.96599999815226 + var_55_14 + arg_55_0 then
				var_55_13.localPosition = Vector3.New(0, 100, 0)
				var_55_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_13.position).x, (manager.ui.mainCamera.transform.position - var_55_13.position).y, (manager.ui.mainCamera.transform.position - var_55_13.position).z)
				var_55_13.localEulerAngles.z = 0
				var_55_13.localEulerAngles.x = 0
				var_55_13.localEulerAngles = var_55_13.localEulerAngles
			end

			local var_55_15 = "1284ui_story"

			if arg_52_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_55_16 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_52_1.stage_.transform)

				var_55_16.name = var_55_15
				var_55_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_[var_55_15] = var_55_16

				local var_55_17 = var_55_16:GetComponentInChildren(typeof(CharacterEffect))

				var_55_17.enabled = true

				local var_55_18 = GameObjectTools.GetOrAddComponent(var_55_16, typeof(DynamicBoneHelper))

				if var_55_18 then
					var_55_18:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_17.transform, false)

				arg_52_1.var_[var_55_15 .. "Animator"] = var_55_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_[var_55_15 .. "Animator"].applyRootMotion = true
				arg_52_1.var_[var_55_15 .. "LipSync"] = var_55_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_19 = arg_52_1.actors_["1284ui_story"].transform

			if 3.8 < arg_52_1.time_ and arg_52_1.time_ <= 3.8 + arg_55_0 then
				arg_52_1.var_.moveOldPos1284ui_story = var_55_19.localPosition

				arg_52_1:ShowWeapon(arg_52_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_55_20 = 0.001

			if 3.8 <= arg_52_1.time_ and arg_52_1.time_ < 3.8 + var_55_20 then
				var_55_19.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_52_1.time_ - 3.8) / var_55_20)
				var_55_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_19.position).x, (manager.ui.mainCamera.transform.position - var_55_19.position).y, (manager.ui.mainCamera.transform.position - var_55_19.position).z)
				var_55_19.localEulerAngles.z = 0
				var_55_19.localEulerAngles.x = 0
				var_55_19.localEulerAngles = var_55_19.localEulerAngles
			end

			if arg_52_1.time_ >= 3.8 + var_55_20 and arg_52_1.time_ < 3.8 + var_55_20 + arg_55_0 then
				var_55_19.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_55_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_19.position).x, (manager.ui.mainCamera.transform.position - var_55_19.position).y, (manager.ui.mainCamera.transform.position - var_55_19.position).z)
				var_55_19.localEulerAngles.z = 0
				var_55_19.localEulerAngles.x = 0
				var_55_19.localEulerAngles = var_55_19.localEulerAngles
			end

			local var_55_21 = arg_52_1.actors_["1284ui_story"]

			if 3.8 < arg_52_1.time_ and arg_52_1.time_ <= 3.8 + arg_55_0 and not isNil(var_55_21) and arg_52_1.var_.characterEffect1284ui_story == nil then
				arg_52_1.var_.characterEffect1284ui_story = var_55_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_22 = 0.200000002980232

			if 3.8 <= arg_52_1.time_ and arg_52_1.time_ < 3.8 + var_55_22 and not isNil(var_55_21) then
				if arg_52_1.var_.characterEffect1284ui_story and not isNil(var_55_21) then
					arg_52_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 3.8 + var_55_22 and arg_52_1.time_ < 3.8 + var_55_22 + arg_55_0 and not isNil(var_55_21) and arg_52_1.var_.characterEffect1284ui_story then
				arg_52_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 3.8 < arg_52_1.time_ and arg_52_1.time_ <= 3.8 + arg_55_0 then
				arg_52_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 3.8 < arg_52_1.time_ and arg_52_1.time_ <= 3.8 + arg_55_0 then
				arg_52_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_55_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_26 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_26

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_26
						arg_52_1.bgmTxt2_.text = var_55_26
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.965999998152256 < arg_52_1.time_ and arg_52_1.time_ <= 0.965999998152256 + arg_55_0 then
				arg_52_1:AudioAction("play", "music", "bgm_story_sad_1", "bgm_story_sad_1", "bgm_story_sad_1.awb")

				local var_55_29 = manager.audio:GetAudioName("bgm_story_sad_1", "bgm_story_sad_1")

				if "" ~= "" then
					if arg_52_1.bgmTxt_.text ~= var_55_29 and arg_52_1.bgmTxt_.text ~= "" then
						if arg_52_1.bgmTxt2_.text ~= "" then
							arg_52_1.bgmTxt_.text = arg_52_1.bgmTxt2_.text
						end

						arg_52_1.bgmTxt2_.text = var_55_29

						arg_52_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_52_1.bgmTxt_.text = var_55_29
						arg_52_1.bgmTxt2_.text = var_55_29
					end

					if arg_52_1.bgmTimer then
						arg_52_1.bgmTimer:Stop()

						arg_52_1.bgmTimer = nil
					end

					if arg_52_1.settingData.show_music_name == 1 then
						arg_52_1.musicController:SetSelectedState("show")
						arg_52_1.musicAnimator_:Play("open", 0, 0)

						if arg_52_1.settingData.music_time ~= 0 then
							arg_52_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_52_1.settingData.music_time), function()
								if arg_52_1 == nil or isNil(arg_52_1.bgmTxt_) then
									return
								end

								arg_52_1.musicController:SetSelectedState("hide")
								arg_52_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_52_1.frameCnt_ <= 1 then
				arg_52_1.dialog_:SetActive(false)
			end

			local var_55_30 = 3.999999999999
			local var_55_31 = 0.175

			if 3.999999999999 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				arg_52_1.dialog_:SetActive(true)

				arg_52_1.dialogCg_.alpha = 0

				local var_55_32 = LeanTween.value(arg_52_1.dialog_, 0, 1, 0.3)

				var_55_32:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_52_1.dialogCg_.alpha = arg_58_0
				end))
				var_55_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_52_1.dialog_)
					var_55_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_52_1.duration_ = arg_52_1.duration_ + 0.3

				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_33 = arg_52_1:GetWordFromCfg(322151013)
				local var_55_34 = arg_52_1:FormatText(var_55_33.content)

				arg_52_1.text_.text = var_55_34

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_36 = 7 <= 0 and var_55_31 or var_55_31 * (utf8.len(var_55_34) / 7)

				if (7 <= 0 and var_55_31 or var_55_31 * (utf8.len(var_55_34) / 7)) > 0 and var_55_31 < var_55_36 then
					arg_52_1.talkMaxDuration = var_55_36
					var_55_30 = var_55_30 + 0.3

					if var_55_36 + var_55_30 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_36 + var_55_30
					end
				end

				arg_52_1.text_.text = var_55_34
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151013", "story_v_out_322151.awb") ~= 0 then
					local var_55_37 = manager.audio:GetVoiceLength("story_v_out_322151", "322151013", "story_v_out_322151.awb") / 1000

					if var_55_37 + var_55_30 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_37 + var_55_30
					end

					if var_55_33.prefab_name ~= "" and arg_52_1.actors_[var_55_33.prefab_name] ~= nil then
						local var_55_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_33.prefab_name].transform, "story_v_out_322151", "322151013", "story_v_out_322151.awb")

						arg_52_1:RecordAudio("322151013", var_55_38)
						arg_52_1:RecordAudio("322151013", var_55_38)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_322151", "322151013", "story_v_out_322151.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_322151", "322151013", "story_v_out_322151.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_39 = var_55_30 + 0.3
			local var_55_40 = math.max(var_55_31, arg_52_1.talkMaxDuration)

			if var_55_30 + 0.3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_39 + var_55_40 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_39) / var_55_40

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_39 + var_55_40 and arg_52_1.time_ < var_55_39 + var_55_40 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play322151014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 322151014
		arg_60_1.duration_ = 3.3

		local var_60_0 = {
			zh = 1.999999999999,
			ja = 3.3
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
				arg_60_0:Play322151015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_63_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_60_1.stage_.transform)

				var_63_0.name = "1211ui_story"
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1211ui_story"] = var_63_0

				local var_63_1 = var_63_0:GetComponentInChildren(typeof(CharacterEffect))

				var_63_1.enabled = true

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end

				arg_60_1:ShowWeapon(var_63_1.transform, false)

				arg_60_1.var_["1211ui_story" .. "Animator"] = var_63_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_60_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_60_1.var_["1211ui_story" .. "LipSync"] = var_63_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_63_3 = arg_60_1.actors_["1211ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1211ui_story = var_63_3.localPosition

				arg_60_1:ShowWeapon(arg_60_1.var_["1211ui_story" .. "Animator"].transform, false)
			end

			local var_63_4 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				var_63_3.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_60_1.time_ - 0) / var_63_4)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				var_63_3.localPosition = Vector3.New(0.7, -0.67, -6.07)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			local var_63_5 = arg_60_1.actors_["1211ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1211ui_story == nil then
				arg_60_1.var_.characterEffect1211ui_story = var_63_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_6 and not isNil(var_63_5) then
				if arg_60_1.var_.characterEffect1211ui_story and not isNil(var_63_5) then
					arg_60_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_6 and arg_60_1.time_ < 0 + var_63_6 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1211ui_story then
				arg_60_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_63_8 = arg_60_1.actors_["1284ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.characterEffect1284ui_story == nil then
				arg_60_1.var_.characterEffect1284ui_story = var_63_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_9 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_9 and not isNil(var_63_8) then
				if arg_60_1.var_.characterEffect1284ui_story and not isNil(var_63_8) then
					arg_60_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_9)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_9 and arg_60_1.time_ < 0 + var_63_9 + arg_63_0 and not isNil(var_63_8) and arg_60_1.var_.characterEffect1284ui_story then
				arg_60_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action5_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_63_10 = 0
			local var_63_11 = 0.175

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_12 = arg_60_1:GetWordFromCfg(322151014)
				local var_63_13 = arg_60_1:FormatText(var_63_12.content)

				arg_60_1.text_.text = var_63_13

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_15 = 7 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_13) / 7)

				if (7 <= 0 and var_63_11 or var_63_11 * (utf8.len(var_63_13) / 7)) > 0 and var_63_11 < var_63_15 then
					arg_60_1.talkMaxDuration = var_63_15

					if var_63_15 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_15 + var_63_10
					end
				end

				arg_60_1.text_.text = var_63_13
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151014", "story_v_out_322151.awb") ~= 0 then
					local var_63_16 = manager.audio:GetVoiceLength("story_v_out_322151", "322151014", "story_v_out_322151.awb") / 1000

					if var_63_16 + var_63_10 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_16 + var_63_10
					end

					if var_63_12.prefab_name ~= "" and arg_60_1.actors_[var_63_12.prefab_name] ~= nil then
						local var_63_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_12.prefab_name].transform, "story_v_out_322151", "322151014", "story_v_out_322151.awb")

						arg_60_1:RecordAudio("322151014", var_63_17)
						arg_60_1:RecordAudio("322151014", var_63_17)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_322151", "322151014", "story_v_out_322151.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_322151", "322151014", "story_v_out_322151.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_18 = math.max(var_63_11, arg_60_1.talkMaxDuration)

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_18 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_18

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_18 and arg_60_1.time_ < var_63_10 + var_63_18 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322151015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 322151015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play322151016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1211ui_story = arg_64_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1211ui_story"].transform.position).z)
				arg_64_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1211ui_story"].transform.localEulerAngles = arg_64_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1211ui_story"].transform.position).z)
				arg_64_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1211ui_story"].transform.localEulerAngles = arg_64_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_67_1 = arg_64_1.actors_["1284ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1284ui_story = var_67_1.localPosition
			end

			local var_67_2 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 then
				var_67_1.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_2)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 then
				var_67_1.localPosition = Vector3.New(0, 100, 0)
				var_67_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_1.position).x, (manager.ui.mainCamera.transform.position - var_67_1.position).y, (manager.ui.mainCamera.transform.position - var_67_1.position).z)
				var_67_1.localEulerAngles.z = 0
				var_67_1.localEulerAngles.x = 0
				var_67_1.localEulerAngles = var_67_1.localEulerAngles
			end

			local var_67_3 = 0
			local var_67_4 = 1.375

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_5 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(322151015).content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 55 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 55)

				if (55 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 55)) > 0 and var_67_4 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_3
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_4, arg_64_1.talkMaxDuration)

			if var_67_3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_3 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_3) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_3 + var_67_8 and arg_64_1.time_ < var_67_3 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322151016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 322151016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play322151017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.275

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(322151016).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 51 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 51)

				if (51 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 51)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play322151017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 322151017
		arg_72_1.duration_ = 3.93

		local var_72_0 = {
			zh = 3.133,
			ja = 3.933
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play322151018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1284ui_story = arg_72_1.actors_["1284ui_story"].transform.localPosition

				arg_72_1:ShowWeapon(arg_72_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).z)
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles = arg_72_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_72_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).z)
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles = arg_72_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["1284ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1284ui_story == nil then
				arg_72_1.var_.characterEffect1284ui_story = var_75_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 and not isNil(var_75_1) then
				if arg_72_1.var_.characterEffect1284ui_story and not isNil(var_75_1) then
					arg_72_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1284ui_story then
				arg_72_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_75_4 = 0
			local var_75_5 = 0.325

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_6 = arg_72_1:GetWordFromCfg(322151017)
				local var_75_7 = arg_72_1:FormatText(var_75_6.content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 13 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 13)

				if (13 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 13)) > 0 and var_75_5 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_4
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151017", "story_v_out_322151.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151017", "story_v_out_322151.awb") / 1000

					if var_75_10 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_4
					end

					if var_75_6.prefab_name ~= "" and arg_72_1.actors_[var_75_6.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_6.prefab_name].transform, "story_v_out_322151", "322151017", "story_v_out_322151.awb")

						arg_72_1:RecordAudio("322151017", var_75_11)
						arg_72_1:RecordAudio("322151017", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_322151", "322151017", "story_v_out_322151.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_322151", "322151017", "story_v_out_322151.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_5, arg_72_1.talkMaxDuration)

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_4) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_4 + var_75_12 and arg_72_1.time_ < var_75_4 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322151018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 322151018
		arg_76_1.duration_ = 2.97

		local var_76_0 = {
			zh = 2.966,
			ja = 2.8
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
				arg_76_0:Play322151019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1211ui_story = arg_76_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1211ui_story"].transform.position).z)
				arg_76_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1211ui_story"].transform.localEulerAngles = arg_76_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_76_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1211ui_story"].transform.position).z)
				arg_76_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1211ui_story"].transform.localEulerAngles = arg_76_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1211ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1211ui_story == nil then
				arg_76_1.var_.characterEffect1211ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1211ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1211ui_story then
				arg_76_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1284ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1284ui_story == nil then
				arg_76_1.var_.characterEffect1284ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_5 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 and not isNil(var_79_4) then
				if arg_76_1.var_.characterEffect1284ui_story and not isNil(var_79_4) then
					arg_76_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_5)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1284ui_story then
				arg_76_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action454")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_79_6 = 0
			local var_79_7 = 0.3

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_6 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(322151018)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 12 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 12)

				if (12 <= 0 and var_79_7 or var_79_7 * (utf8.len(var_79_9) / 12)) > 0 and var_79_7 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11

					if var_79_11 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_6
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151018", "story_v_out_322151.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151018", "story_v_out_322151.awb") / 1000

					if var_79_12 + var_79_6 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_6
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_322151", "322151018", "story_v_out_322151.awb")

						arg_76_1:RecordAudio("322151018", var_79_13)
						arg_76_1:RecordAudio("322151018", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_322151", "322151018", "story_v_out_322151.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_322151", "322151018", "story_v_out_322151.awb")
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
				actorName = "1211ui_story",
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
	Play322151019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 322151019
		arg_80_1.duration_ = 8.93

		local var_80_0 = {
			zh = 7.666,
			ja = 8.933
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
				arg_80_0:Play322151020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.775

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(322151019)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 31 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 31)

				if (31 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 31)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151019", "story_v_out_322151.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151019", "story_v_out_322151.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_322151", "322151019", "story_v_out_322151.awb")

						arg_80_1:RecordAudio("322151019", var_83_6)
						arg_80_1:RecordAudio("322151019", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_322151", "322151019", "story_v_out_322151.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_322151", "322151019", "story_v_out_322151.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play322151020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 322151020
		arg_84_1.duration_ = 8.27

		local var_84_0 = {
			zh = 7.266,
			ja = 8.266
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
				arg_84_0:Play322151021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_2")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_87_0 = 0
			local var_87_1 = 0.775

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(322151020)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 31 <= 0 and var_87_1 or var_87_1 * (utf8.len(var_87_3) / 31)

				if (31 <= 0 and var_87_1 or var_87_1 * (utf8.len(var_87_3) / 31)) > 0 and var_87_1 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151020", "story_v_out_322151.awb") ~= 0 then
					local var_87_6 = manager.audio:GetVoiceLength("story_v_out_322151", "322151020", "story_v_out_322151.awb") / 1000

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end

					if var_87_2.prefab_name ~= "" and arg_84_1.actors_[var_87_2.prefab_name] ~= nil then
						local var_87_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_2.prefab_name].transform, "story_v_out_322151", "322151020", "story_v_out_322151.awb")

						arg_84_1:RecordAudio("322151020", var_87_7)
						arg_84_1:RecordAudio("322151020", var_87_7)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_322151", "322151020", "story_v_out_322151.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_322151", "322151020", "story_v_out_322151.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play322151021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 322151021
		arg_88_1.duration_ = 24.03

		local var_88_0 = {
			zh = 16.266,
			ja = 24.033
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
				arg_88_0:Play322151022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.525

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:GetWordFromCfg(322151021)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 61 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 61)

				if (61 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 61)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151021", "story_v_out_322151.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151021", "story_v_out_322151.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_322151", "322151021", "story_v_out_322151.awb")

						arg_88_1:RecordAudio("322151021", var_91_6)
						arg_88_1:RecordAudio("322151021", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_322151", "322151021", "story_v_out_322151.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_322151", "322151021", "story_v_out_322151.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_7 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_7

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play322151022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 322151022
		arg_92_1.duration_ = 3.5

		local var_92_0 = {
			zh = 2.566,
			ja = 3.5
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
				arg_92_0:Play322151023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_95_0 = 0
			local var_95_1 = 0.25

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(322151022)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 10 <= 0 and var_95_1 or var_95_1 * (utf8.len(var_95_3) / 10)

				if (10 <= 0 and var_95_1 or var_95_1 * (utf8.len(var_95_3) / 10)) > 0 and var_95_1 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151022", "story_v_out_322151.awb") ~= 0 then
					local var_95_6 = manager.audio:GetVoiceLength("story_v_out_322151", "322151022", "story_v_out_322151.awb") / 1000

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end

					if var_95_2.prefab_name ~= "" and arg_92_1.actors_[var_95_2.prefab_name] ~= nil then
						local var_95_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_2.prefab_name].transform, "story_v_out_322151", "322151022", "story_v_out_322151.awb")

						arg_92_1:RecordAudio("322151022", var_95_7)
						arg_92_1:RecordAudio("322151022", var_95_7)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_322151", "322151022", "story_v_out_322151.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_322151", "322151022", "story_v_out_322151.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_8 and arg_92_1.time_ < var_95_0 + var_95_8 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play322151023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 322151023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play322151024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1211ui_story = arg_96_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1211ui_story"].transform.position).z)
				arg_96_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1211ui_story"].transform.localEulerAngles = arg_96_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1211ui_story"].transform.position).z)
				arg_96_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1211ui_story"].transform.localEulerAngles = arg_96_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1284ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1284ui_story = var_99_1.localPosition
			end

			local var_99_2 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 then
				var_99_1.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_2)
				var_99_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_1.position).x, (manager.ui.mainCamera.transform.position - var_99_1.position).y, (manager.ui.mainCamera.transform.position - var_99_1.position).z)
				var_99_1.localEulerAngles.z = 0
				var_99_1.localEulerAngles.x = 0
				var_99_1.localEulerAngles = var_99_1.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 then
				var_99_1.localPosition = Vector3.New(0, 100, 0)
				var_99_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_1.position).x, (manager.ui.mainCamera.transform.position - var_99_1.position).y, (manager.ui.mainCamera.transform.position - var_99_1.position).z)
				var_99_1.localEulerAngles.z = 0
				var_99_1.localEulerAngles.x = 0
				var_99_1.localEulerAngles = var_99_1.localEulerAngles
			end

			local var_99_3 = 0
			local var_99_4 = 0.95

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_3 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_5 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(322151023).content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 38 <= 0 and var_99_4 or var_99_4 * (utf8.len(var_99_5) / 38)

				if (38 <= 0 and var_99_4 or var_99_4 * (utf8.len(var_99_5) / 38)) > 0 and var_99_4 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_3 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_3
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_4, arg_96_1.talkMaxDuration)

			if var_99_3 <= arg_96_1.time_ and arg_96_1.time_ < var_99_3 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_3) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_3 + var_99_8 and arg_96_1.time_ < var_99_3 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play322151024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 322151024
		arg_100_1.duration_ = 11.9

		local var_100_0 = {
			zh = 10.6,
			ja = 11.9
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play322151025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1211ui_story = arg_100_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1211ui_story"].transform.position).z)
				arg_100_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1211ui_story"].transform.localEulerAngles = arg_100_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_100_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1211ui_story"].transform.position).z)
				arg_100_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1211ui_story"].transform.localEulerAngles = arg_100_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1211ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1211ui_story == nil then
				arg_100_1.var_.characterEffect1211ui_story = var_103_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 and not isNil(var_103_1) then
				if arg_100_1.var_.characterEffect1211ui_story and not isNil(var_103_1) then
					arg_100_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 and not isNil(var_103_1) and arg_100_1.var_.characterEffect1211ui_story then
				arg_100_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_103_4 = 0
			local var_103_5 = 0.925

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(322151024)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 37 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 37)

				if (37 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 37)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151024", "story_v_out_322151.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151024", "story_v_out_322151.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_322151", "322151024", "story_v_out_322151.awb")

						arg_100_1:RecordAudio("322151024", var_103_11)
						arg_100_1:RecordAudio("322151024", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_322151", "322151024", "story_v_out_322151.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_322151", "322151024", "story_v_out_322151.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play322151025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 322151025
		arg_104_1.duration_ = 8.8

		local var_104_0 = {
			zh = 5.466,
			ja = 8.8
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play322151026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1284ui_story = arg_104_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1284ui_story"].transform.position).z)
				arg_104_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1284ui_story"].transform.localEulerAngles = arg_104_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_104_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1284ui_story"].transform.position).z)
				arg_104_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1284ui_story"].transform.localEulerAngles = arg_104_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_107_1 = arg_104_1.actors_["1284ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1284ui_story == nil then
				arg_104_1.var_.characterEffect1284ui_story = var_107_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 and not isNil(var_107_1) then
				if arg_104_1.var_.characterEffect1284ui_story and not isNil(var_107_1) then
					arg_104_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1284ui_story then
				arg_104_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_107_4 = arg_104_1.actors_["1211ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1211ui_story == nil then
				arg_104_1.var_.characterEffect1211ui_story = var_107_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_5 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_5 and not isNil(var_107_4) then
				if arg_104_1.var_.characterEffect1211ui_story and not isNil(var_107_4) then
					arg_104_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_5)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_5 and arg_104_1.time_ < 0 + var_107_5 + arg_107_0 and not isNil(var_107_4) and arg_104_1.var_.characterEffect1211ui_story then
				arg_104_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_6 = 0
			local var_107_7 = 0.625

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(322151025)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_11 = 25 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 25)

				if (25 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_9) / 25)) > 0 and var_107_7 < var_107_11 then
					arg_104_1.talkMaxDuration = var_107_11

					if var_107_11 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_11 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151025", "story_v_out_322151.awb") ~= 0 then
					local var_107_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151025", "story_v_out_322151.awb") / 1000

					if var_107_12 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_6
					end

					if var_107_8.prefab_name ~= "" and arg_104_1.actors_[var_107_8.prefab_name] ~= nil then
						local var_107_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_8.prefab_name].transform, "story_v_out_322151", "322151025", "story_v_out_322151.awb")

						arg_104_1:RecordAudio("322151025", var_107_13)
						arg_104_1:RecordAudio("322151025", var_107_13)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_322151", "322151025", "story_v_out_322151.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_322151", "322151025", "story_v_out_322151.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_14 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_14 and arg_104_1.time_ < var_107_6 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play322151026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 322151026
		arg_108_1.duration_ = 7.3

		local var_108_0 = {
			zh = 6.1,
			ja = 7.3
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play322151027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1211ui_story = arg_108_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1211ui_story"].transform.position).z)
				arg_108_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1211ui_story"].transform.localEulerAngles = arg_108_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_108_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1211ui_story"].transform.position).z)
				arg_108_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1211ui_story"].transform.localEulerAngles = arg_108_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1211ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1211ui_story == nil then
				arg_108_1.var_.characterEffect1211ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1211ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1211ui_story then
				arg_108_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["1284ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1284ui_story == nil then
				arg_108_1.var_.characterEffect1284ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_5 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_5 and not isNil(var_111_4) then
				if arg_108_1.var_.characterEffect1284ui_story and not isNil(var_111_4) then
					arg_108_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_5)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_5 and arg_108_1.time_ < 0 + var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1284ui_story then
				arg_108_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_111_6 = 0
			local var_111_7 = 0.6

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:GetWordFromCfg(322151026)
				local var_111_9 = arg_108_1:FormatText(var_111_8.content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 24 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_9) / 24)

				if (24 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_9) / 24)) > 0 and var_111_7 < var_111_11 then
					arg_108_1.talkMaxDuration = var_111_11

					if var_111_11 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151026", "story_v_out_322151.awb") ~= 0 then
					local var_111_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151026", "story_v_out_322151.awb") / 1000

					if var_111_12 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_12 + var_111_6
					end

					if var_111_8.prefab_name ~= "" and arg_108_1.actors_[var_111_8.prefab_name] ~= nil then
						local var_111_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_8.prefab_name].transform, "story_v_out_322151", "322151026", "story_v_out_322151.awb")

						arg_108_1:RecordAudio("322151026", var_111_13)
						arg_108_1:RecordAudio("322151026", var_111_13)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_322151", "322151026", "story_v_out_322151.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_322151", "322151026", "story_v_out_322151.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_14 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_14 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_14

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_14 and arg_108_1.time_ < var_111_6 + var_111_14 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play322151027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 322151027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play322151028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1211ui_story = arg_112_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).z)
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles = arg_112_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).z)
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles = arg_112_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1284ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1284ui_story = var_115_1.localPosition
			end

			local var_115_2 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 then
				var_115_1.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_2)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 then
				var_115_1.localPosition = Vector3.New(0, 100, 0)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			local var_115_3 = 0
			local var_115_4 = 1.3

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_3 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_5 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(322151027).content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 52 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 52)

				if (52 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 52)) > 0 and var_115_4 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_3 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_3
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_4, arg_112_1.talkMaxDuration)

			if var_115_3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_3 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_3) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_3 + var_115_8 and arg_112_1.time_ < var_115_3 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play322151028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322151028
		arg_116_1.duration_ = 5.03

		local var_116_0 = {
			zh = 2.766,
			ja = 5.033
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play322151029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1211ui_story = arg_116_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1211ui_story"].transform.position).z)
				arg_116_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1211ui_story"].transform.localEulerAngles = arg_116_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_116_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1211ui_story"].transform.position).z)
				arg_116_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1211ui_story"].transform.localEulerAngles = arg_116_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1211ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1211ui_story == nil then
				arg_116_1.var_.characterEffect1211ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1211ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1211ui_story then
				arg_116_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_2")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_119_4 = 0
			local var_119_5 = 0.15

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(322151028)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 6 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 6)

				if (6 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 6)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151028", "story_v_out_322151.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151028", "story_v_out_322151.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_322151", "322151028", "story_v_out_322151.awb")

						arg_116_1:RecordAudio("322151028", var_119_11)
						arg_116_1:RecordAudio("322151028", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_322151", "322151028", "story_v_out_322151.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_322151", "322151028", "story_v_out_322151.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play322151029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322151029
		arg_120_1.duration_ = 2.6

		local var_120_0 = {
			zh = 2.6,
			ja = 2.2
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play322151030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1284ui_story = arg_120_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1284ui_story"].transform.position).z)
				arg_120_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1284ui_story"].transform.localEulerAngles = arg_120_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_120_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1284ui_story"].transform.position).z)
				arg_120_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1284ui_story"].transform.localEulerAngles = arg_120_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["1284ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1284ui_story == nil then
				arg_120_1.var_.characterEffect1284ui_story = var_123_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 and not isNil(var_123_1) then
				if arg_120_1.var_.characterEffect1284ui_story and not isNil(var_123_1) then
					arg_120_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 and not isNil(var_123_1) and arg_120_1.var_.characterEffect1284ui_story then
				arg_120_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_123_4 = arg_120_1.actors_["1211ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1211ui_story == nil then
				arg_120_1.var_.characterEffect1211ui_story = var_123_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_5 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_5 and not isNil(var_123_4) then
				if arg_120_1.var_.characterEffect1211ui_story and not isNil(var_123_4) then
					arg_120_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_5)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_5 and arg_120_1.time_ < 0 + var_123_5 + arg_123_0 and not isNil(var_123_4) and arg_120_1.var_.characterEffect1211ui_story then
				arg_120_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_6 = 0
			local var_123_7 = 0.2

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_8 = arg_120_1:GetWordFromCfg(322151029)
				local var_123_9 = arg_120_1:FormatText(var_123_8.content)

				arg_120_1.text_.text = var_123_9

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 8 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 8)

				if (8 <= 0 and var_123_7 or var_123_7 * (utf8.len(var_123_9) / 8)) > 0 and var_123_7 < var_123_11 then
					arg_120_1.talkMaxDuration = var_123_11

					if var_123_11 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_9
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151029", "story_v_out_322151.awb") ~= 0 then
					local var_123_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151029", "story_v_out_322151.awb") / 1000

					if var_123_12 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_6
					end

					if var_123_8.prefab_name ~= "" and arg_120_1.actors_[var_123_8.prefab_name] ~= nil then
						local var_123_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_8.prefab_name].transform, "story_v_out_322151", "322151029", "story_v_out_322151.awb")

						arg_120_1:RecordAudio("322151029", var_123_13)
						arg_120_1:RecordAudio("322151029", var_123_13)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322151", "322151029", "story_v_out_322151.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322151", "322151029", "story_v_out_322151.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_14 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_14 and arg_120_1.time_ < var_123_6 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play322151030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322151030
		arg_124_1.duration_ = 5.33

		local var_124_0 = {
			zh = 4.666,
			ja = 5.333
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322151031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1211ui_story = arg_124_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1211ui_story"].transform.position).z)
				arg_124_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1211ui_story"].transform.localEulerAngles = arg_124_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_124_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1211ui_story"].transform.position).z)
				arg_124_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1211ui_story"].transform.localEulerAngles = arg_124_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_127_1 = arg_124_1.actors_["1211ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1211ui_story == nil then
				arg_124_1.var_.characterEffect1211ui_story = var_127_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 and not isNil(var_127_1) then
				if arg_124_1.var_.characterEffect1211ui_story and not isNil(var_127_1) then
					arg_124_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1211ui_story then
				arg_124_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_127_4 = arg_124_1.actors_["1284ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect1284ui_story == nil then
				arg_124_1.var_.characterEffect1284ui_story = var_127_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_5 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_5 and not isNil(var_127_4) then
				if arg_124_1.var_.characterEffect1284ui_story and not isNil(var_127_4) then
					arg_124_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_5)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_5 and arg_124_1.time_ < 0 + var_127_5 + arg_127_0 and not isNil(var_127_4) and arg_124_1.var_.characterEffect1284ui_story then
				arg_124_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_127_6 = 0
			local var_127_7 = 0.325

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(322151030)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 13 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 13)

				if (13 <= 0 and var_127_7 or var_127_7 * (utf8.len(var_127_9) / 13)) > 0 and var_127_7 < var_127_11 then
					arg_124_1.talkMaxDuration = var_127_11

					if var_127_11 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151030", "story_v_out_322151.awb") ~= 0 then
					local var_127_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151030", "story_v_out_322151.awb") / 1000

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end

					if var_127_8.prefab_name ~= "" and arg_124_1.actors_[var_127_8.prefab_name] ~= nil then
						local var_127_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_8.prefab_name].transform, "story_v_out_322151", "322151030", "story_v_out_322151.awb")

						arg_124_1:RecordAudio("322151030", var_127_13)
						arg_124_1:RecordAudio("322151030", var_127_13)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_322151", "322151030", "story_v_out_322151.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_322151", "322151030", "story_v_out_322151.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_14 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_14 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_14

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_14 and arg_124_1.time_ < var_127_6 + var_127_14 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play322151031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322151031
		arg_128_1.duration_ = 2.4

		local var_128_0 = {
			zh = 2.4,
			ja = 1.999999999999
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play322151032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1284ui_story"]) and arg_128_1.var_.characterEffect1284ui_story == nil then
				arg_128_1.var_.characterEffect1284ui_story = arg_128_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1284ui_story"]) then
				if arg_128_1.var_.characterEffect1284ui_story and not isNil(arg_128_1.actors_["1284ui_story"]) then
					arg_128_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1284ui_story"]) and arg_128_1.var_.characterEffect1284ui_story then
				arg_128_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1211ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1211ui_story == nil then
				arg_128_1.var_.characterEffect1211ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1211ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1211ui_story then
				arg_128_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action9_1")
			end

			local var_131_4 = 0
			local var_131_5 = 0.175

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(322151031)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 7 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 7)

				if (7 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 7)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151031", "story_v_out_322151.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151031", "story_v_out_322151.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_322151", "322151031", "story_v_out_322151.awb")

						arg_128_1:RecordAudio("322151031", var_131_11)
						arg_128_1:RecordAudio("322151031", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322151", "322151031", "story_v_out_322151.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322151", "322151031", "story_v_out_322151.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play322151032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322151032
		arg_132_1.duration_ = 17.43

		local var_132_0 = {
			zh = 12.366,
			ja = 17.433
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play322151033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1211ui_story"]) and arg_132_1.var_.characterEffect1211ui_story == nil then
				arg_132_1.var_.characterEffect1211ui_story = arg_132_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1211ui_story"]) then
				if arg_132_1.var_.characterEffect1211ui_story and not isNil(arg_132_1.actors_["1211ui_story"]) then
					arg_132_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1211ui_story"]) and arg_132_1.var_.characterEffect1211ui_story then
				arg_132_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_135_2 = arg_132_1.actors_["1284ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1284ui_story == nil then
				arg_132_1.var_.characterEffect1284ui_story = var_135_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_3 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.characterEffect1284ui_story and not isNil(var_135_2) then
					arg_132_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_3)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1284ui_story then
				arg_132_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_135_4 = 0
			local var_135_5 = 1.15

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(322151032)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 46 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 46)

				if (46 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 46)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151032", "story_v_out_322151.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151032", "story_v_out_322151.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_322151", "322151032", "story_v_out_322151.awb")

						arg_132_1:RecordAudio("322151032", var_135_11)
						arg_132_1:RecordAudio("322151032", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322151", "322151032", "story_v_out_322151.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322151", "322151032", "story_v_out_322151.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play322151033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322151033
		arg_136_1.duration_ = 10.67

		local var_136_0 = {
			zh = 7.133,
			ja = 10.666
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play322151034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.7

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:GetWordFromCfg(322151033)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 28 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 28)

				if (28 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 28)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151033", "story_v_out_322151.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151033", "story_v_out_322151.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_322151", "322151033", "story_v_out_322151.awb")

						arg_136_1:RecordAudio("322151033", var_139_6)
						arg_136_1:RecordAudio("322151033", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_322151", "322151033", "story_v_out_322151.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_322151", "322151033", "story_v_out_322151.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play322151034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322151034
		arg_140_1.duration_ = 10.87

		local var_140_0 = {
			zh = 9.833,
			ja = 10.866
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play322151035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_2")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_143_0 = 0
			local var_143_1 = 0.775

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_2 = arg_140_1:GetWordFromCfg(322151034)
				local var_143_3 = arg_140_1:FormatText(var_143_2.content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 31 <= 0 and var_143_1 or var_143_1 * (utf8.len(var_143_3) / 31)

				if (31 <= 0 and var_143_1 or var_143_1 * (utf8.len(var_143_3) / 31)) > 0 and var_143_1 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_0
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151034", "story_v_out_322151.awb") ~= 0 then
					local var_143_6 = manager.audio:GetVoiceLength("story_v_out_322151", "322151034", "story_v_out_322151.awb") / 1000

					if var_143_6 + var_143_0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_0
					end

					if var_143_2.prefab_name ~= "" and arg_140_1.actors_[var_143_2.prefab_name] ~= nil then
						local var_143_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_2.prefab_name].transform, "story_v_out_322151", "322151034", "story_v_out_322151.awb")

						arg_140_1:RecordAudio("322151034", var_143_7)
						arg_140_1:RecordAudio("322151034", var_143_7)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322151", "322151034", "story_v_out_322151.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322151", "322151034", "story_v_out_322151.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_1, arg_140_1.talkMaxDuration)

			if var_143_0 <= arg_140_1.time_ and arg_140_1.time_ < var_143_0 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_0) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_0 + var_143_8 and arg_140_1.time_ < var_143_0 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322151035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322151035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play322151036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1211ui_story = arg_144_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_147_0 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				arg_144_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_0)
				arg_144_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1211ui_story"].transform.position).z)
				arg_144_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1211ui_story"].transform.localEulerAngles = arg_144_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				arg_144_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1211ui_story"].transform.position).z)
				arg_144_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1211ui_story"].transform.localEulerAngles = arg_144_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_147_1 = arg_144_1.actors_["1284ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1284ui_story = var_147_1.localPosition
			end

			local var_147_2 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 then
				var_147_1.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_2)
				var_147_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_1.position).x, (manager.ui.mainCamera.transform.position - var_147_1.position).y, (manager.ui.mainCamera.transform.position - var_147_1.position).z)
				var_147_1.localEulerAngles.z = 0
				var_147_1.localEulerAngles.x = 0
				var_147_1.localEulerAngles = var_147_1.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 then
				var_147_1.localPosition = Vector3.New(0, 100, 0)
				var_147_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_1.position).x, (manager.ui.mainCamera.transform.position - var_147_1.position).y, (manager.ui.mainCamera.transform.position - var_147_1.position).z)
				var_147_1.localEulerAngles.z = 0
				var_147_1.localEulerAngles.x = 0
				var_147_1.localEulerAngles = var_147_1.localEulerAngles
			end

			local var_147_3 = 0
			local var_147_4 = 1.25

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_3 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_5 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(322151035).content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 50 <= 0 and var_147_4 or var_147_4 * (utf8.len(var_147_5) / 50)

				if (50 <= 0 and var_147_4 or var_147_4 * (utf8.len(var_147_5) / 50)) > 0 and var_147_4 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_3 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_3
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_4, arg_144_1.talkMaxDuration)

			if var_147_3 <= arg_144_1.time_ and arg_144_1.time_ < var_147_3 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_3) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_3 + var_147_8 and arg_144_1.time_ < var_147_3 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play322151036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322151036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322151037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.625

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(322151036).content)

				arg_148_1.text_.text = var_151_1

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_3 = 25 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 25)

				if (25 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 25)) > 0 and var_151_0 < var_151_3 then
					arg_148_1.talkMaxDuration = var_151_3

					if var_151_3 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_3 + 0
					end
				end

				arg_148_1.text_.text = var_151_1
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_4 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_4

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play322151037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322151037
		arg_152_1.duration_ = 2

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play322151038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if arg_152_1.actors_["1043ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1043ui_story"))) then
				local var_155_0 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_152_1.stage_.transform)

				var_155_0.name = "1043ui_story"
				var_155_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_["1043ui_story"] = var_155_0

				local var_155_1 = var_155_0:GetComponentInChildren(typeof(CharacterEffect))

				var_155_1.enabled = true

				local var_155_2 = GameObjectTools.GetOrAddComponent(var_155_0, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(false)
				end

				arg_152_1:ShowWeapon(var_155_1.transform, false)

				arg_152_1.var_["1043ui_story" .. "Animator"] = var_155_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_152_1.var_["1043ui_story" .. "Animator"].applyRootMotion = true
				arg_152_1.var_["1043ui_story" .. "LipSync"] = var_155_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_155_3 = arg_152_1.actors_["1043ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1043ui_story = var_155_3.localPosition
			end

			local var_155_4 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				var_155_3.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1043ui_story, Vector3.New(0.01, -1.01, -5.73), (arg_152_1.time_ - 0) / var_155_4)
				var_155_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_3.position).x, (manager.ui.mainCamera.transform.position - var_155_3.position).y, (manager.ui.mainCamera.transform.position - var_155_3.position).z)
				var_155_3.localEulerAngles.z = 0
				var_155_3.localEulerAngles.x = 0
				var_155_3.localEulerAngles = var_155_3.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				var_155_3.localPosition = Vector3.New(0.01, -1.01, -5.73)
				var_155_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_3.position).x, (manager.ui.mainCamera.transform.position - var_155_3.position).y, (manager.ui.mainCamera.transform.position - var_155_3.position).z)
				var_155_3.localEulerAngles.z = 0
				var_155_3.localEulerAngles.x = 0
				var_155_3.localEulerAngles = var_155_3.localEulerAngles
			end

			local var_155_5 = arg_152_1.actors_["1043ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_5) and arg_152_1.var_.characterEffect1043ui_story == nil then
				arg_152_1.var_.characterEffect1043ui_story = var_155_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_6 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_6 and not isNil(var_155_5) then
				if arg_152_1.var_.characterEffect1043ui_story and not isNil(var_155_5) then
					arg_152_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_6 and arg_152_1.time_ < 0 + var_155_6 + arg_155_0 and not isNil(var_155_5) and arg_152_1.var_.characterEffect1043ui_story then
				arg_152_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_155_8 = 0
			local var_155_9 = 0.05

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1156].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_10 = arg_152_1:GetWordFromCfg(322151037)
				local var_155_11 = arg_152_1:FormatText(var_155_10.content)

				arg_152_1.text_.text = var_155_11

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_13 = 2 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 2)

				if (2 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 2)) > 0 and var_155_9 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_8
					end
				end

				arg_152_1.text_.text = var_155_11
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151037", "story_v_out_322151.awb") ~= 0 then
					local var_155_14 = manager.audio:GetVoiceLength("story_v_out_322151", "322151037", "story_v_out_322151.awb") / 1000

					if var_155_14 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_8
					end

					if var_155_10.prefab_name ~= "" and arg_152_1.actors_[var_155_10.prefab_name] ~= nil then
						local var_155_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_10.prefab_name].transform, "story_v_out_322151", "322151037", "story_v_out_322151.awb")

						arg_152_1:RecordAudio("322151037", var_155_15)
						arg_152_1:RecordAudio("322151037", var_155_15)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322151", "322151037", "story_v_out_322151.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322151", "322151037", "story_v_out_322151.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_16 = math.max(var_155_9, arg_152_1.talkMaxDuration)

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_16 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_8) / var_155_16

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_8 + var_155_16 and arg_152_1.time_ < var_155_8 + var_155_16 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play322151038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322151038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play322151039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1043ui_story = arg_156_1.actors_["1043ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1043ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1043ui_story, Vector3.New(0, 100, 0), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1043ui_story"].transform.position).z)
				arg_156_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1043ui_story"].transform.localEulerAngles = arg_156_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1043ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.actors_["1043ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1043ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1043ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1043ui_story"].transform.position).z)
				arg_156_1.actors_["1043ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1043ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1043ui_story"].transform.localEulerAngles = arg_156_1.actors_["1043ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1043ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1043ui_story == nil then
				arg_156_1.var_.characterEffect1043ui_story = var_159_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 and not isNil(var_159_1) then
				if arg_156_1.var_.characterEffect1043ui_story and not isNil(var_159_1) then
					arg_156_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1043ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_2)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 and not isNil(var_159_1) and arg_156_1.var_.characterEffect1043ui_story then
				arg_156_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1043ui_story.fillRatio = 0.5
			end

			local var_159_3 = 0
			local var_159_4 = 0.75

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_3 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(322151038).content)

				arg_156_1.text_.text = var_159_5

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 30 <= 0 and var_159_4 or var_159_4 * (utf8.len(var_159_5) / 30)

				if (30 <= 0 and var_159_4 or var_159_4 * (utf8.len(var_159_5) / 30)) > 0 and var_159_4 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_3 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_3
					end
				end

				arg_156_1.text_.text = var_159_5
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_4, arg_156_1.talkMaxDuration)

			if var_159_3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_3 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_3) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_3 + var_159_8 and arg_156_1.time_ < var_159_3 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play322151039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322151039
		arg_160_1.duration_ = 9

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322151040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.bgs_.ST0502 == nil then
				local var_163_0 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0502")
				var_163_0.name = "ST0502"
				var_163_0.transform.parent = arg_160_1.stage_.transform
				var_163_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_.ST0502 = var_163_0
			end

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				local var_163_1 = arg_160_1.bgs_.ST0502

				arg_160_1.bgs_.ST0502.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_2 = var_163_1:GetComponent("SpriteRenderer")

				if var_163_2 and var_163_2.sprite then
					local var_163_3 = 2 * (var_163_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_1.transform.localScale = Vector3.New(var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "ST0502" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_4 = 4

			if 4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_4 + 0.3 and arg_160_1.time_ < var_163_4 + 0.3 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_5 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_6 = 2

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 then
				local var_163_7 = Color.New(0, 0, 0)

				var_163_7.a = Mathf.Lerp(0, 1, (arg_160_1.time_ - var_163_5) / var_163_6)
				arg_160_1.mask_.color = var_163_7
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 then
				local var_163_8 = Color.New(0, 0, 0)

				var_163_8.a = 1
				arg_160_1.mask_.color = var_163_8
			end

			local var_163_9 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_10 = 2

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_10 then
				local var_163_11 = Color.New(0, 0, 0)

				var_163_11.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_9) / var_163_10)
				arg_160_1.mask_.color = var_163_11
			end

			if arg_160_1.time_ >= var_163_9 + var_163_10 and arg_160_1.time_ < var_163_9 + var_163_10 + arg_163_0 then
				local var_163_12 = Color.New(0, 0, 0)

				arg_160_1.mask_.enabled = false
				var_163_12.a = 0
				arg_160_1.mask_.color = var_163_12
			end

			if 0.1 < arg_160_1.time_ and arg_160_1.time_ <= 0.1 + arg_163_0 then
				arg_160_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1.53333333333333 < arg_160_1.time_ and arg_160_1.time_ <= 1.53333333333333 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0.1 < arg_160_1.time_ and arg_160_1.time_ <= 0.1 + arg_163_0 then
				arg_160_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_163_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_17 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_17

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_17
						arg_160_1.bgmTxt2_.text = var_163_17
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_18 = 4
			local var_163_19 = 0.575

			if 4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_20 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_20:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_160_1.dialogCg_.alpha = arg_165_0
				end))
				var_163_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_21 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(322151039).content)

				arg_160_1.text_.text = var_163_21

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_23 = 23 <= 0 and var_163_19 or var_163_19 * (utf8.len(var_163_21) / 23)

				if (23 <= 0 and var_163_19 or var_163_19 * (utf8.len(var_163_21) / 23)) > 0 and var_163_19 < var_163_23 then
					arg_160_1.talkMaxDuration = var_163_23
					var_163_18 = var_163_18 + 0.3

					if var_163_23 + var_163_18 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_23 + var_163_18
					end
				end

				arg_160_1.text_.text = var_163_21
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_24 = var_163_18 + 0.3
			local var_163_25 = math.max(var_163_19, arg_160_1.talkMaxDuration)

			if var_163_18 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_24 + var_163_25 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_24) / var_163_25

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_24 + var_163_25 and arg_160_1.time_ < var_163_24 + var_163_25 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play322151040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 322151040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play322151041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.45

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(322151040).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 58 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 58)

				if (58 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 58)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play322151041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 322151041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play322151042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 1.625

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(322151041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 65 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 65)

				if (65 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 65)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play322151042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 322151042
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play322151043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 1.575

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(322151042).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 63 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 63)

				if (63 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 63)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play322151043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 322151043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play322151044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.2

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(322151043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 8 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 8)

				if (8 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 8)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play322151044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 322151044
		arg_183_1.duration_ = 3.5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play322151045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if arg_183_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_186_0 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_183_1.stage_.transform)

				var_186_0.name = "1020ui_story"
				var_186_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_183_1.actors_["1020ui_story"] = var_186_0

				local var_186_1 = var_186_0:GetComponentInChildren(typeof(CharacterEffect))

				var_186_1.enabled = true

				local var_186_2 = GameObjectTools.GetOrAddComponent(var_186_0, typeof(DynamicBoneHelper))

				if var_186_2 then
					var_186_2:EnableDynamicBone(false)
				end

				arg_183_1:ShowWeapon(var_186_1.transform, false)

				arg_183_1.var_["1020ui_story" .. "Animator"] = var_186_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_183_1.var_["1020ui_story" .. "Animator"].applyRootMotion = true
				arg_183_1.var_["1020ui_story" .. "LipSync"] = var_186_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_186_3 = arg_183_1.actors_["1020ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1020ui_story = var_186_3.localPosition
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_3.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_183_1.time_ - 0) / var_186_4)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_3.localPosition = Vector3.New(0, -0.85, -6.25)
				var_186_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_3.position).x, (manager.ui.mainCamera.transform.position - var_186_3.position).y, (manager.ui.mainCamera.transform.position - var_186_3.position).z)
				var_186_3.localEulerAngles.z = 0
				var_186_3.localEulerAngles.x = 0
				var_186_3.localEulerAngles = var_186_3.localEulerAngles
			end

			local var_186_5 = arg_183_1.actors_["1020ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1020ui_story == nil then
				arg_183_1.var_.characterEffect1020ui_story = var_186_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_6 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_6 and not isNil(var_186_5) then
				if arg_183_1.var_.characterEffect1020ui_story and not isNil(var_186_5) then
					arg_183_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_6 and arg_183_1.time_ < 0 + var_186_6 + arg_186_0 and not isNil(var_186_5) and arg_183_1.var_.characterEffect1020ui_story then
				arg_183_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action1_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				if arg_183_1.var_.characterEffect1020ui_story == nil then
					arg_183_1.var_.characterEffect1020ui_story = arg_183_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_186_8 = arg_183_1.var_.characterEffect1020ui_story

				arg_183_1.var_.characterEffect1020ui_story.imageEffect:turnOff()

				var_186_8.interferenceEffect.enabled = true
				var_186_8.interferenceEffect.noise = 0
				var_186_8.interferenceEffect.simTimeScale = 1
				var_186_8.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				if arg_183_1.var_.characterEffect1020ui_story == nil then
					arg_183_1.var_.characterEffect1020ui_story = arg_183_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_183_1.var_.characterEffect1020ui_story.imageEffect:turnOn(false)
			end

			local var_186_10 = 0
			local var_186_11 = 0.2

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_12 = arg_183_1:GetWordFromCfg(322151044)
				local var_186_13 = arg_183_1:FormatText(var_186_12.content)

				arg_183_1.text_.text = var_186_13

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_15 = 8 <= 0 and var_186_11 or var_186_11 * (utf8.len(var_186_13) / 8)

				if (8 <= 0 and var_186_11 or var_186_11 * (utf8.len(var_186_13) / 8)) > 0 and var_186_11 < var_186_15 then
					arg_183_1.talkMaxDuration = var_186_15

					if var_186_15 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_15 + var_186_10
					end
				end

				arg_183_1.text_.text = var_186_13
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151044", "story_v_out_322151.awb") ~= 0 then
					local var_186_16 = manager.audio:GetVoiceLength("story_v_out_322151", "322151044", "story_v_out_322151.awb") / 1000

					if var_186_16 + var_186_10 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_16 + var_186_10
					end

					if var_186_12.prefab_name ~= "" and arg_183_1.actors_[var_186_12.prefab_name] ~= nil then
						local var_186_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_12.prefab_name].transform, "story_v_out_322151", "322151044", "story_v_out_322151.awb")

						arg_183_1:RecordAudio("322151044", var_186_17)
						arg_183_1:RecordAudio("322151044", var_186_17)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_322151", "322151044", "story_v_out_322151.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_322151", "322151044", "story_v_out_322151.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_18 = math.max(var_186_11, arg_183_1.talkMaxDuration)

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_18 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_10) / var_186_18

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_10 + var_186_18 and arg_183_1.time_ < var_186_10 + var_186_18 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play322151045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322151045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play322151046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1020ui_story"]) and arg_187_1.var_.characterEffect1020ui_story == nil then
				arg_187_1.var_.characterEffect1020ui_story = arg_187_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1020ui_story"]) then
				if arg_187_1.var_.characterEffect1020ui_story and not isNil(arg_187_1.actors_["1020ui_story"]) then
					arg_187_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1020ui_story"]) and arg_187_1.var_.characterEffect1020ui_story then
				arg_187_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.55

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(322151045).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 22 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 22)

				if (22 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 22)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play322151046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322151046
		arg_191_1.duration_ = 8.7

		local var_191_0 = {
			zh = 8,
			ja = 8.7
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322151047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1020ui_story = arg_191_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).z)
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles = arg_191_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_191_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1020ui_story"].transform.position).z)
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1020ui_story"].transform.localEulerAngles = arg_191_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1020ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1020ui_story == nil then
				arg_191_1.var_.characterEffect1020ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1020ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1020ui_story then
				arg_191_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				if arg_191_1.var_.characterEffect1020ui_story == nil then
					arg_191_1.var_.characterEffect1020ui_story = arg_191_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_194_4 = arg_191_1.var_.characterEffect1020ui_story

				arg_191_1.var_.characterEffect1020ui_story.imageEffect:turnOff()

				var_194_4.interferenceEffect.enabled = true
				var_194_4.interferenceEffect.noise = 0
				var_194_4.interferenceEffect.simTimeScale = 1
				var_194_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				if arg_191_1.var_.characterEffect1020ui_story == nil then
					arg_191_1.var_.characterEffect1020ui_story = arg_191_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_191_1.var_.characterEffect1020ui_story.imageEffect:turnOn(false)
			end

			local var_194_6 = 0
			local var_194_7 = 0.975

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_6 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_8 = arg_191_1:GetWordFromCfg(322151046)
				local var_194_9 = arg_191_1:FormatText(var_194_8.content)

				arg_191_1.text_.text = var_194_9

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_11 = 39 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 39)

				if (39 <= 0 and var_194_7 or var_194_7 * (utf8.len(var_194_9) / 39)) > 0 and var_194_7 < var_194_11 then
					arg_191_1.talkMaxDuration = var_194_11

					if var_194_11 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_6
					end
				end

				arg_191_1.text_.text = var_194_9
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151046", "story_v_out_322151.awb") ~= 0 then
					local var_194_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151046", "story_v_out_322151.awb") / 1000

					if var_194_12 + var_194_6 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_12 + var_194_6
					end

					if var_194_8.prefab_name ~= "" and arg_191_1.actors_[var_194_8.prefab_name] ~= nil then
						local var_194_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_8.prefab_name].transform, "story_v_out_322151", "322151046", "story_v_out_322151.awb")

						arg_191_1:RecordAudio("322151046", var_194_13)
						arg_191_1:RecordAudio("322151046", var_194_13)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_322151", "322151046", "story_v_out_322151.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_322151", "322151046", "story_v_out_322151.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_14 = math.max(var_194_7, arg_191_1.talkMaxDuration)

			if var_194_6 <= arg_191_1.time_ and arg_191_1.time_ < var_194_6 + var_194_14 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_6) / var_194_14

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_6 + var_194_14 and arg_191_1.time_ < var_194_6 + var_194_14 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play322151047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322151047
		arg_195_1.duration_ = 5.3

		local var_195_0 = {
			zh = 3.9,
			ja = 5.3
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play322151048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action3_2")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				if arg_195_1.var_.characterEffect1020ui_story == nil then
					arg_195_1.var_.characterEffect1020ui_story = arg_195_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_198_0 = arg_195_1.var_.characterEffect1020ui_story

				arg_195_1.var_.characterEffect1020ui_story.imageEffect:turnOff()

				var_198_0.interferenceEffect.enabled = true
				var_198_0.interferenceEffect.noise = 0
				var_198_0.interferenceEffect.simTimeScale = 1
				var_198_0.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				if arg_195_1.var_.characterEffect1020ui_story == nil then
					arg_195_1.var_.characterEffect1020ui_story = arg_195_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_195_1.var_.characterEffect1020ui_story.imageEffect:turnOn(false)
			end

			local var_198_2 = arg_195_1.actors_["1020ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1020ui_story = var_198_2.localPosition
			end

			local var_198_3 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 then
				var_198_2.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_195_1.time_ - 0) / var_198_3)
				var_198_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_2.position).x, (manager.ui.mainCamera.transform.position - var_198_2.position).y, (manager.ui.mainCamera.transform.position - var_198_2.position).z)
				var_198_2.localEulerAngles.z = 0
				var_198_2.localEulerAngles.x = 0
				var_198_2.localEulerAngles = var_198_2.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 then
				var_198_2.localPosition = Vector3.New(0, -0.85, -6.25)
				var_198_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_2.position).x, (manager.ui.mainCamera.transform.position - var_198_2.position).y, (manager.ui.mainCamera.transform.position - var_198_2.position).z)
				var_198_2.localEulerAngles.z = 0
				var_198_2.localEulerAngles.x = 0
				var_198_2.localEulerAngles = var_198_2.localEulerAngles
			end

			local var_198_4 = arg_195_1.actors_["1020ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1020ui_story == nil then
				arg_195_1.var_.characterEffect1020ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_5 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_5 and not isNil(var_198_4) then
				if arg_195_1.var_.characterEffect1020ui_story and not isNil(var_198_4) then
					arg_195_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_5 and arg_195_1.time_ < 0 + var_198_5 + arg_198_0 and not isNil(var_198_4) and arg_195_1.var_.characterEffect1020ui_story then
				arg_195_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_198_7 = 0
			local var_198_8 = 0.45

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_7 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_9 = arg_195_1:GetWordFromCfg(322151047)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_12 = 18 <= 0 and var_198_8 or var_198_8 * (utf8.len(var_198_10) / 18)

				if (18 <= 0 and var_198_8 or var_198_8 * (utf8.len(var_198_10) / 18)) > 0 and var_198_8 < var_198_12 then
					arg_195_1.talkMaxDuration = var_198_12

					if var_198_12 + var_198_7 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_7
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151047", "story_v_out_322151.awb") ~= 0 then
					local var_198_13 = manager.audio:GetVoiceLength("story_v_out_322151", "322151047", "story_v_out_322151.awb") / 1000

					if var_198_13 + var_198_7 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_7
					end

					if var_198_9.prefab_name ~= "" and arg_195_1.actors_[var_198_9.prefab_name] ~= nil then
						local var_198_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_9.prefab_name].transform, "story_v_out_322151", "322151047", "story_v_out_322151.awb")

						arg_195_1:RecordAudio("322151047", var_198_14)
						arg_195_1:RecordAudio("322151047", var_198_14)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_322151", "322151047", "story_v_out_322151.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_322151", "322151047", "story_v_out_322151.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_15 = math.max(var_198_8, arg_195_1.talkMaxDuration)

			if var_198_7 <= arg_195_1.time_ and arg_195_1.time_ < var_198_7 + var_198_15 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_7) / var_198_15

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_7 + var_198_15 and arg_195_1.time_ < var_198_7 + var_198_15 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play322151048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322151048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322151049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1020ui_story"]) and arg_199_1.var_.characterEffect1020ui_story == nil then
				arg_199_1.var_.characterEffect1020ui_story = arg_199_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1020ui_story"]) then
				if arg_199_1.var_.characterEffect1020ui_story and not isNil(arg_199_1.actors_["1020ui_story"]) then
					arg_199_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1020ui_story"]) and arg_199_1.var_.characterEffect1020ui_story then
				arg_199_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 0.975

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(322151048).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 39 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 39)

				if (39 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 39)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play322151049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322151049
		arg_203_1.duration_ = 9

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322151050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if arg_203_1.bgs_.ST0510 == nil then
				local var_206_0 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0510")
				var_206_0.name = "ST0510"
				var_206_0.transform.parent = arg_203_1.stage_.transform
				var_206_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_.ST0510 = var_206_0
			end

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				local var_206_1 = arg_203_1.bgs_.ST0510

				arg_203_1.bgs_.ST0510.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_206_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_2 = var_206_1:GetComponent("SpriteRenderer")

				if var_206_2 and var_206_2.sprite then
					local var_206_3 = 2 * (var_206_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_206_1.transform.localScale = Vector3.New(var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, var_206_3 / var_206_2.sprite.bounds.size.y < var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x and var_206_3 * manager.ui.mainCameraCom_.aspect / var_206_2.sprite.bounds.size.x or var_206_3 / var_206_2.sprite.bounds.size.y, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "ST0510" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_4 = 4

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= var_206_4 + 0.3 and arg_203_1.time_ < var_206_4 + 0.3 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_5 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_6 = 2

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_6 then
				local var_206_7 = Color.New(0, 0, 0)

				var_206_7.a = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_5) / var_206_6)
				arg_203_1.mask_.color = var_206_7
			end

			if arg_203_1.time_ >= var_206_5 + var_206_6 and arg_203_1.time_ < var_206_5 + var_206_6 + arg_206_0 then
				local var_206_8 = Color.New(0, 0, 0)

				var_206_8.a = 1
				arg_203_1.mask_.color = var_206_8
			end

			local var_206_9 = 2

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_9 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_10 = 2

			if var_206_9 <= arg_203_1.time_ and arg_203_1.time_ < var_206_9 + var_206_10 then
				local var_206_11 = Color.New(0, 0, 0)

				var_206_11.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_9) / var_206_10)
				arg_203_1.mask_.color = var_206_11
			end

			if arg_203_1.time_ >= var_206_9 + var_206_10 and arg_203_1.time_ < var_206_9 + var_206_10 + arg_206_0 then
				local var_206_12 = Color.New(0, 0, 0)

				arg_203_1.mask_.enabled = false
				var_206_12.a = 0
				arg_203_1.mask_.color = var_206_12
			end

			local var_206_13 = arg_203_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_203_1.time_ and arg_203_1.time_ <= 1.96599999815226 + arg_206_0 then
				arg_203_1.var_.moveOldPos1020ui_story = var_206_13.localPosition
			end

			local var_206_14 = 0.001

			if 1.96599999815226 <= arg_203_1.time_ and arg_203_1.time_ < 1.96599999815226 + var_206_14 then
				var_206_13.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 1.96599999815226) / var_206_14)
				var_206_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_13.position).x, (manager.ui.mainCamera.transform.position - var_206_13.position).y, (manager.ui.mainCamera.transform.position - var_206_13.position).z)
				var_206_13.localEulerAngles.z = 0
				var_206_13.localEulerAngles.x = 0
				var_206_13.localEulerAngles = var_206_13.localEulerAngles
			end

			if arg_203_1.time_ >= 1.96599999815226 + var_206_14 and arg_203_1.time_ < 1.96599999815226 + var_206_14 + arg_206_0 then
				var_206_13.localPosition = Vector3.New(0, 100, 0)
				var_206_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_13.position).x, (manager.ui.mainCamera.transform.position - var_206_13.position).y, (manager.ui.mainCamera.transform.position - var_206_13.position).z)
				var_206_13.localEulerAngles.z = 0
				var_206_13.localEulerAngles.x = 0
				var_206_13.localEulerAngles = var_206_13.localEulerAngles
			end

			local var_206_15 = 2

			arg_203_1.isInRecall_ = false

			if var_206_15 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.screenFilterGo_:SetActive(true)

				arg_203_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_206_2, iter_206_3 in pairs(arg_203_1.actors_) do
					for iter_206_4, iter_206_5 in ipairs((iter_206_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_206_5.color = iter_206_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_206_16 = 0.034000001847744

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_16 then
				arg_203_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_203_1.time_ - var_206_15) / var_206_16)
			end

			if arg_203_1.time_ >= var_206_15 + var_206_16 and arg_203_1.time_ < var_206_15 + var_206_16 + arg_206_0 then
				arg_203_1.screenFilterEffect_.weight = 1
			end

			if 0.166666666666667 < arg_203_1.time_ and arg_203_1.time_ <= 0.166666666666667 + arg_206_0 then
				arg_203_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.56666666666667 < arg_203_1.time_ and arg_203_1.time_ <= 1.56666666666667 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_data", "")
			end

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				if arg_203_1.var_.characterEffect1020ui_story == nil then
					arg_203_1.var_.characterEffect1020ui_story = arg_203_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_206_19 = arg_203_1.var_.characterEffect1020ui_story

				arg_203_1.var_.characterEffect1020ui_story.imageEffect:turnOff()

				var_206_19.interferenceEffect.enabled = false
				var_206_19.interferenceEffect.noise = 0
				var_206_19.interferenceEffect.simTimeScale = 1
				var_206_19.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 2 < arg_203_1.time_ and arg_203_1.time_ <= 2 + arg_206_0 then
				if arg_203_1.var_.characterEffect1020ui_story == nil then
					arg_203_1.var_.characterEffect1020ui_story = arg_203_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_203_1.var_.characterEffect1020ui_story.imageEffect:turnOff()
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_21 = 4
			local var_206_22 = 0.175

			if 4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_21 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_23 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_23:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_24 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(322151049).content)

				arg_203_1.text_.text = var_206_24

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_26 = 7 <= 0 and var_206_22 or var_206_22 * (utf8.len(var_206_24) / 7)

				if (7 <= 0 and var_206_22 or var_206_22 * (utf8.len(var_206_24) / 7)) > 0 and var_206_22 < var_206_26 then
					arg_203_1.talkMaxDuration = var_206_26
					var_206_21 = var_206_21 + 0.3

					if var_206_26 + var_206_21 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_26 + var_206_21
					end
				end

				arg_203_1.text_.text = var_206_24
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_27 = var_206_21 + 0.3
			local var_206_28 = math.max(var_206_22, arg_203_1.talkMaxDuration)

			if var_206_21 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_27 + var_206_28 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_27) / var_206_28

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_27 + var_206_28 and arg_203_1.time_ < var_206_27 + var_206_28 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play322151050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 322151050
		arg_209_1.duration_ = 11.87

		local var_209_0 = {
			zh = 8,
			ja = 11.866
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play322151051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_212_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_209_1.stage_.transform)

				var_212_0.name = "1089ui_story"
				var_212_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1089ui_story"] = var_212_0

				local var_212_1 = var_212_0:GetComponentInChildren(typeof(CharacterEffect))

				var_212_1.enabled = true

				local var_212_2 = GameObjectTools.GetOrAddComponent(var_212_0, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(false)
				end

				arg_209_1:ShowWeapon(var_212_1.transform, false)

				arg_209_1.var_["1089ui_story" .. "Animator"] = var_212_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_209_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_209_1.var_["1089ui_story" .. "LipSync"] = var_212_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_212_3 = arg_209_1.actors_["1089ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1089ui_story = var_212_3.localPosition
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_3.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_209_1.time_ - 0) / var_212_4)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_3.localPosition = Vector3.New(0, -1.1, -6.17)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			local var_212_5 = arg_209_1.actors_["1089ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1089ui_story == nil then
				arg_209_1.var_.characterEffect1089ui_story = var_212_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_6 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.characterEffect1089ui_story and not isNil(var_212_5) then
					arg_209_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1089ui_story then
				arg_209_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_8 = 0
			local var_212_9 = 0.925

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(322151050)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 37 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 37)

				if (37 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 37)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151050", "story_v_out_322151.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_322151", "322151050", "story_v_out_322151.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_322151", "322151050", "story_v_out_322151.awb")

						arg_209_1:RecordAudio("322151050", var_212_15)
						arg_209_1:RecordAudio("322151050", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_322151", "322151050", "story_v_out_322151.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_322151", "322151050", "story_v_out_322151.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play322151051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 322151051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play322151052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1089ui_story"]) and arg_213_1.var_.characterEffect1089ui_story == nil then
				arg_213_1.var_.characterEffect1089ui_story = arg_213_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1089ui_story"]) then
				if arg_213_1.var_.characterEffect1089ui_story and not isNil(arg_213_1.actors_["1089ui_story"]) then
					arg_213_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1089ui_story"]) and arg_213_1.var_.characterEffect1089ui_story then
				arg_213_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_216_1 = 0
			local var_216_2 = 0.4

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(322151051).content)

				arg_213_1.text_.text = var_216_3

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 16 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 16)

				if (16 <= 0 and var_216_2 or var_216_2 * (utf8.len(var_216_3) / 16)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_1 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_1
					end
				end

				arg_213_1.text_.text = var_216_3
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_6 = math.max(var_216_2, arg_213_1.talkMaxDuration)

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_6 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_1) / var_216_6

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_1 + var_216_6 and arg_213_1.time_ < var_216_1 + var_216_6 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play322151052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 322151052
		arg_217_1.duration_ = 9.63

		local var_217_0 = {
			zh = 7.933,
			ja = 9.633
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play322151053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1089ui_story = arg_217_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1089ui_story"].transform.position).z)
				arg_217_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1089ui_story"].transform.localEulerAngles = arg_217_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_217_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1089ui_story"].transform.position).z)
				arg_217_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1089ui_story"].transform.localEulerAngles = arg_217_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1089ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1089ui_story == nil then
				arg_217_1.var_.characterEffect1089ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1089ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1089ui_story then
				arg_217_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_220_4 = 0
			local var_220_5 = 0.65

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_6 = arg_217_1:GetWordFromCfg(322151052)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 26 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 26)

				if (26 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 26)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151052", "story_v_out_322151.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151052", "story_v_out_322151.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_out_322151", "322151052", "story_v_out_322151.awb")

						arg_217_1:RecordAudio("322151052", var_220_11)
						arg_217_1:RecordAudio("322151052", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_322151", "322151052", "story_v_out_322151.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_322151", "322151052", "story_v_out_322151.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play322151053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 322151053
		arg_221_1.duration_ = 5.93

		local var_221_0 = {
			zh = 5.799999999999,
			ja = 5.933
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play322151054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 2.00000000298023 < arg_221_1.time_ and arg_221_1.time_ <= 2.00000000298023 + arg_224_0 then
				local var_224_0 = arg_221_1.bgs_.ST0510

				arg_221_1.bgs_.ST0510.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_224_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_1 = var_224_0:GetComponent("SpriteRenderer")

				if var_224_1 and var_224_1.sprite then
					local var_224_2 = 2 * (var_224_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_224_0.transform.localScale = Vector3.New(var_224_2 / var_224_1.sprite.bounds.size.y < var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x and var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x or var_224_2 / var_224_1.sprite.bounds.size.y, var_224_2 / var_224_1.sprite.bounds.size.y < var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x and var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x or var_224_2 / var_224_1.sprite.bounds.size.y, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "ST0510" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_3 = 4.00000000298023

			if 4.00000000298023 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			if arg_221_1.time_ >= var_224_3 + 0.3 and arg_221_1.time_ < var_224_3 + 0.3 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_4 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_5 = 2

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_5 then
				local var_224_6 = Color.New(0, 0, 0)

				var_224_6.a = Mathf.Lerp(0, 1, (arg_221_1.time_ - var_224_4) / var_224_5)
				arg_221_1.mask_.color = var_224_6
			end

			if arg_221_1.time_ >= var_224_4 + var_224_5 and arg_221_1.time_ < var_224_4 + var_224_5 + arg_224_0 then
				local var_224_7 = Color.New(0, 0, 0)

				var_224_7.a = 1
				arg_221_1.mask_.color = var_224_7
			end

			local var_224_8 = 2

			if 2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_9 = 2

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 then
				local var_224_10 = Color.New(0, 0, 0)

				var_224_10.a = Mathf.Lerp(1, 0, (arg_221_1.time_ - var_224_8) / var_224_9)
				arg_221_1.mask_.color = var_224_10
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 then
				local var_224_11 = Color.New(0, 0, 0)

				arg_221_1.mask_.enabled = false
				var_224_11.a = 0
				arg_221_1.mask_.color = var_224_11
			end

			local var_224_12 = arg_221_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_221_1.time_ and arg_221_1.time_ <= 1.96599999815226 + arg_224_0 then
				arg_221_1.var_.moveOldPos1089ui_story = var_224_12.localPosition
			end

			local var_224_13 = 0.001

			if 1.96599999815226 <= arg_221_1.time_ and arg_221_1.time_ < 1.96599999815226 + var_224_13 then
				var_224_12.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 1.96599999815226) / var_224_13)
				var_224_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_12.position).x, (manager.ui.mainCamera.transform.position - var_224_12.position).y, (manager.ui.mainCamera.transform.position - var_224_12.position).z)
				var_224_12.localEulerAngles.z = 0
				var_224_12.localEulerAngles.x = 0
				var_224_12.localEulerAngles = var_224_12.localEulerAngles
			end

			if arg_221_1.time_ >= 1.96599999815226 + var_224_13 and arg_221_1.time_ < 1.96599999815226 + var_224_13 + arg_224_0 then
				var_224_12.localPosition = Vector3.New(0, 100, 0)
				var_224_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_12.position).x, (manager.ui.mainCamera.transform.position - var_224_12.position).y, (manager.ui.mainCamera.transform.position - var_224_12.position).z)
				var_224_12.localEulerAngles.z = 0
				var_224_12.localEulerAngles.x = 0
				var_224_12.localEulerAngles = var_224_12.localEulerAngles
			end

			local var_224_14 = "10103ui_story"

			if arg_221_1.actors_["10103ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10103ui_story"))) then
				local var_224_15 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_221_1.stage_.transform)

				var_224_15.name = var_224_14
				var_224_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_[var_224_14] = var_224_15

				local var_224_16 = var_224_15:GetComponentInChildren(typeof(CharacterEffect))

				var_224_16.enabled = true

				local var_224_17 = GameObjectTools.GetOrAddComponent(var_224_15, typeof(DynamicBoneHelper))

				if var_224_17 then
					var_224_17:EnableDynamicBone(false)
				end

				arg_221_1:ShowWeapon(var_224_16.transform, false)

				arg_221_1.var_[var_224_14 .. "Animator"] = var_224_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_221_1.var_[var_224_14 .. "Animator"].applyRootMotion = true
				arg_221_1.var_[var_224_14 .. "LipSync"] = var_224_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_224_18 = arg_221_1.actors_["10103ui_story"].transform

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				arg_221_1.var_.moveOldPos10103ui_story = var_224_18.localPosition

				local var_224_19 = GameObjectTools.GetOrAddComponent(var_224_18.gameObject, typeof(DynamicBoneHelper))

				if var_224_19 then
					var_224_19:EnableDynamicBone(false)
				end
			end

			local var_224_20 = 0.001

			if 3.8 <= arg_221_1.time_ and arg_221_1.time_ < 3.8 + var_224_20 then
				var_224_18.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10103ui_story, Vector3.New(-0.7, -0.95, -6.2), (arg_221_1.time_ - 3.8) / var_224_20)
				var_224_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_18.position).x, (manager.ui.mainCamera.transform.position - var_224_18.position).y, (manager.ui.mainCamera.transform.position - var_224_18.position).z)
				var_224_18.localEulerAngles.z = 0
				var_224_18.localEulerAngles.x = 0
				var_224_18.localEulerAngles = var_224_18.localEulerAngles
			end

			if arg_221_1.time_ >= 3.8 + var_224_20 and arg_221_1.time_ < 3.8 + var_224_20 + arg_224_0 then
				var_224_18.localPosition = Vector3.New(-0.7, -0.95, -6.2)
				var_224_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_18.position).x, (manager.ui.mainCamera.transform.position - var_224_18.position).y, (manager.ui.mainCamera.transform.position - var_224_18.position).z)
				var_224_18.localEulerAngles.z = 0
				var_224_18.localEulerAngles.x = 0
				var_224_18.localEulerAngles = var_224_18.localEulerAngles

				local var_224_21 = GameObjectTools.GetOrAddComponent(var_224_18.gameObject, typeof(DynamicBoneHelper))

				if var_224_21 then
					var_224_21:EnableDynamicBone(true)
				end
			end

			local var_224_22 = arg_221_1.actors_["10103ui_story"]

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 and not isNil(var_224_22) and arg_221_1.var_.characterEffect10103ui_story == nil then
				arg_221_1.var_.characterEffect10103ui_story = var_224_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_23 = 0.200000002980232

			if 3.8 <= arg_221_1.time_ and arg_221_1.time_ < 3.8 + var_224_23 and not isNil(var_224_22) then
				if arg_221_1.var_.characterEffect10103ui_story and not isNil(var_224_22) then
					arg_221_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 3.8 + var_224_23 and arg_221_1.time_ < 3.8 + var_224_23 + arg_224_0 and not isNil(var_224_22) and arg_221_1.var_.characterEffect10103ui_story then
				arg_221_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_224_25 = arg_221_1.actors_["1089ui_story"]

			if 1.98333333333333 < arg_221_1.time_ and arg_221_1.time_ <= 1.98333333333333 + arg_224_0 and not isNil(var_224_25) and arg_221_1.var_.characterEffect1089ui_story == nil then
				arg_221_1.var_.characterEffect1089ui_story = var_224_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_26 = 0.0166666666666666

			if 1.98333333333333 <= arg_221_1.time_ and arg_221_1.time_ < 1.98333333333333 + var_224_26 and not isNil(var_224_25) then
				if arg_221_1.var_.characterEffect1089ui_story and not isNil(var_224_25) then
					arg_221_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 1.98333333333333) / var_224_26)
				end
			end

			if arg_221_1.time_ >= 1.98333333333333 + var_224_26 and arg_221_1.time_ < 1.98333333333333 + var_224_26 + arg_224_0 and not isNil(var_224_25) and arg_221_1.var_.characterEffect1089ui_story then
				arg_221_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				arg_221_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				arg_221_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= 3.8 + arg_224_0 then
				if not isNil(arg_221_1.actors_["10103ui_story"]) then
					local var_224_27 = GameObjectTools.GetOrAddComponent(arg_221_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_224_27 then
						var_224_27:EnableDynamicBone(true)
					end
				end
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_28 = 3.8
			local var_224_29 = 0.125

			if 3.8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_28 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_30 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_30:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_31 = arg_221_1:GetWordFromCfg(322151053)
				local var_224_32 = arg_221_1:FormatText(var_224_31.content)

				arg_221_1.text_.text = var_224_32

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_34 = 5 <= 0 and var_224_29 or var_224_29 * (utf8.len(var_224_32) / 5)

				if (5 <= 0 and var_224_29 or var_224_29 * (utf8.len(var_224_32) / 5)) > 0 and var_224_29 < var_224_34 then
					arg_221_1.talkMaxDuration = var_224_34
					var_224_28 = var_224_28 + 0.3

					if var_224_34 + var_224_28 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_34 + var_224_28
					end
				end

				arg_221_1.text_.text = var_224_32
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151053", "story_v_out_322151.awb") ~= 0 then
					local var_224_35 = manager.audio:GetVoiceLength("story_v_out_322151", "322151053", "story_v_out_322151.awb") / 1000

					if var_224_35 + var_224_28 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_35 + var_224_28
					end

					if var_224_31.prefab_name ~= "" and arg_221_1.actors_[var_224_31.prefab_name] ~= nil then
						local var_224_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_31.prefab_name].transform, "story_v_out_322151", "322151053", "story_v_out_322151.awb")

						arg_221_1:RecordAudio("322151053", var_224_36)
						arg_221_1:RecordAudio("322151053", var_224_36)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_322151", "322151053", "story_v_out_322151.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_322151", "322151053", "story_v_out_322151.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_37 = var_224_28 + 0.3
			local var_224_38 = math.max(var_224_29, arg_221_1.talkMaxDuration)

			if var_224_28 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_37 + var_224_38 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_37) / var_224_38

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_37 + var_224_38 and arg_221_1.time_ < var_224_37 + var_224_38 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play322151054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322151054
		arg_227_1.duration_ = 17.87

		local var_227_0 = {
			zh = 9.633,
			ja = 17.866
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play322151055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1089ui_story = arg_227_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1089ui_story"].transform.position).z)
				arg_227_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1089ui_story"].transform.localEulerAngles = arg_227_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_227_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["1089ui_story"].transform.position).z)
				arg_227_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["1089ui_story"].transform.localEulerAngles = arg_227_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["1089ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1089ui_story == nil then
				arg_227_1.var_.characterEffect1089ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect1089ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect1089ui_story then
				arg_227_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_230_4 = arg_227_1.actors_["10103ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect10103ui_story == nil then
				arg_227_1.var_.characterEffect10103ui_story = var_230_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_5 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_5 and not isNil(var_230_4) then
				if arg_227_1.var_.characterEffect10103ui_story and not isNil(var_230_4) then
					arg_227_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_227_1.var_.characterEffect10103ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_5)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_5 and arg_227_1.time_ < 0 + var_230_5 + arg_230_0 and not isNil(var_230_4) and arg_227_1.var_.characterEffect10103ui_story then
				arg_227_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_227_1.var_.characterEffect10103ui_story.fillRatio = 0.5
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_230_6 = 0
			local var_230_7 = 1.125

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_8 = arg_227_1:GetWordFromCfg(322151054)
				local var_230_9 = arg_227_1:FormatText(var_230_8.content)

				arg_227_1.text_.text = var_230_9

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 45 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 45)

				if (45 <= 0 and var_230_7 or var_230_7 * (utf8.len(var_230_9) / 45)) > 0 and var_230_7 < var_230_11 then
					arg_227_1.talkMaxDuration = var_230_11

					if var_230_11 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_9
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151054", "story_v_out_322151.awb") ~= 0 then
					local var_230_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151054", "story_v_out_322151.awb") / 1000

					if var_230_12 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_12 + var_230_6
					end

					if var_230_8.prefab_name ~= "" and arg_227_1.actors_[var_230_8.prefab_name] ~= nil then
						local var_230_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_8.prefab_name].transform, "story_v_out_322151", "322151054", "story_v_out_322151.awb")

						arg_227_1:RecordAudio("322151054", var_230_13)
						arg_227_1:RecordAudio("322151054", var_230_13)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_322151", "322151054", "story_v_out_322151.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_322151", "322151054", "story_v_out_322151.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_14 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_14

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_14 and arg_227_1.time_ < var_230_6 + var_230_14 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play322151055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322151055
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play322151056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_9000

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1089ui_story = arg_231_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).z)
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles = arg_231_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_231_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1089ui_story"].transform.position).z)
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1089ui_story"].transform.localEulerAngles = arg_231_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["10103ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10103ui_story = var_234_1.localPosition

				local var_234_2 = GameObjectTools.GetOrAddComponent(var_234_1.gameObject, typeof(DynamicBoneHelper))

				if var_234_2 then
					var_234_2:EnableDynamicBone(false)
				end
			end

			local var_234_3 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 then
				var_234_1.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10103ui_story, Vector3.New(0, 100, 0), (arg_231_1.time_ - 0) / var_234_3)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 then
				var_234_1.localPosition = Vector3.New(0, 100, 0)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles

				local var_234_4 = GameObjectTools.GetOrAddComponent(var_234_1.gameObject, typeof(DynamicBoneHelper))

				if var_234_4 then
					var_234_4:EnableDynamicBone(true)
				end
			end

			local var_234_5 = arg_231_1.actors_["1089ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1089ui_story == nil then
				arg_231_1.var_.characterEffect1089ui_story = var_234_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_6 and not isNil(var_234_5) then
				if arg_231_1.var_.characterEffect1089ui_story and not isNil(var_234_5) then
					arg_231_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_6)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_6 and arg_231_1.time_ < 0 + var_234_6 + arg_234_0 and not isNil(var_234_5) and arg_231_1.var_.characterEffect1089ui_story then
				arg_231_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_231_1.time_ and arg_231_1.time_ <= 0.1 + arg_234_0 then
				arg_231_1:AudioAction("play", "effect", "se_story_17", "se_story_17_ui", "")
			end

			if 0.1 < arg_231_1.time_ and arg_231_1.time_ <= 0.1 + arg_234_0 then
				local var_234_8 = arg_231_1.var_.effect1055

				if not arg_231_1.var_.effect1055 then
					var_234_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), manager.ui.mainCamera.transform)
					var_234_8.name = "1055"
					arg_231_1.var_.effect1055 = var_234_8
				else
					var_234_8.transform:SetParent(var_234_9000)
				end

				var_234_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_234_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_234_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_234_0, iter_234_1 in ipairs((var_234_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_234_1.transform.localScale = Vector3.New(iter_234_1.transform.localScale.x / var_234_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_234_1.transform.localScale.y / var_234_10, iter_234_1.transform.localScale.z)
				end
			end

			local var_234_12 = 0
			local var_234_13 = 0.875

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_14 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(322151055).content)

				arg_231_1.text_.text = var_234_14

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_16 = 35 <= 0 and var_234_13 or var_234_13 * (utf8.len(var_234_14) / 35)

				if (35 <= 0 and var_234_13 or var_234_13 * (utf8.len(var_234_14) / 35)) > 0 and var_234_13 < var_234_16 then
					arg_231_1.talkMaxDuration = var_234_16

					if var_234_16 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_16 + var_234_12
					end
				end

				arg_231_1.text_.text = var_234_14
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_17 = math.max(var_234_13, arg_231_1.talkMaxDuration)

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_17 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_12) / var_234_17

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_12 + var_234_17 and arg_231_1.time_ < var_234_12 + var_234_17 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play322151056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322151056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play322151057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				if arg_235_1.var_.effect1055 then
					Object.Destroy(arg_235_1.var_.effect1055)

					arg_235_1.var_.effect1055 = nil
				end
			end

			local var_238_1 = 0
			local var_238_2 = 0.925

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(322151056).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 37 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 37)

				if (37 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 37)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play322151057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322151057
		arg_239_1.duration_ = 10.7

		local var_239_0 = {
			zh = 5.466,
			ja = 10.7
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play322151058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1089ui_story = arg_239_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1089ui_story"].transform.position).z)
				arg_239_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1089ui_story"].transform.localEulerAngles = arg_239_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, -1.1, -6.17)
				arg_239_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1089ui_story"].transform.position).z)
				arg_239_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1089ui_story"].transform.localEulerAngles = arg_239_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1089ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1089ui_story == nil then
				arg_239_1.var_.characterEffect1089ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1089ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1089ui_story then
				arg_239_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_242_4 = 0
			local var_242_5 = 0.625

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(322151057)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 25 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 25)

				if (25 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 25)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151057", "story_v_out_322151.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151057", "story_v_out_322151.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_322151", "322151057", "story_v_out_322151.awb")

						arg_239_1:RecordAudio("322151057", var_242_11)
						arg_239_1:RecordAudio("322151057", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_322151", "322151057", "story_v_out_322151.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_322151", "322151057", "story_v_out_322151.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play322151058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 322151058
		arg_243_1.duration_ = 9

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play322151059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 2 < arg_243_1.time_ and arg_243_1.time_ <= 2 + arg_246_0 then
				local var_246_0 = arg_243_1.bgs_.ST0502

				arg_243_1.bgs_.ST0502.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_246_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_246_1 = var_246_0:GetComponent("SpriteRenderer")

				if var_246_1 and var_246_1.sprite then
					local var_246_2 = 2 * (var_246_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_246_0.transform.localScale = Vector3.New(var_246_2 / var_246_1.sprite.bounds.size.y < var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x and var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x or var_246_2 / var_246_1.sprite.bounds.size.y, var_246_2 / var_246_1.sprite.bounds.size.y < var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x and var_246_2 * manager.ui.mainCameraCom_.aspect / var_246_1.sprite.bounds.size.x or var_246_2 / var_246_1.sprite.bounds.size.y, 0)
				end

				for iter_246_0, iter_246_1 in pairs(arg_243_1.bgs_) do
					if iter_246_0 ~= "ST0502" then
						iter_246_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_246_3 = 3.8

			if 3.8 < arg_243_1.time_ and arg_243_1.time_ <= var_246_3 + arg_246_0 then
				arg_243_1.allBtn_.enabled = false
			end

			if arg_243_1.time_ >= var_246_3 + 0.3 and arg_243_1.time_ < var_246_3 + 0.3 + arg_246_0 then
				arg_243_1.allBtn_.enabled = true
			end

			local var_246_4 = 0

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_5 = 2

			if var_246_4 <= arg_243_1.time_ and arg_243_1.time_ < var_246_4 + var_246_5 then
				local var_246_6 = Color.New(0, 0, 0)

				var_246_6.a = Mathf.Lerp(0, 1, (arg_243_1.time_ - var_246_4) / var_246_5)
				arg_243_1.mask_.color = var_246_6
			end

			if arg_243_1.time_ >= var_246_4 + var_246_5 and arg_243_1.time_ < var_246_4 + var_246_5 + arg_246_0 then
				local var_246_7 = Color.New(0, 0, 0)

				var_246_7.a = 1
				arg_243_1.mask_.color = var_246_7
			end

			local var_246_8 = 2

			if 2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.mask_.enabled = true
				arg_243_1.mask_.raycastTarget = true

				arg_243_1:SetGaussion(false)
			end

			local var_246_9 = 2

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_9 then
				local var_246_10 = Color.New(0, 0, 0)

				var_246_10.a = Mathf.Lerp(1, 0, (arg_243_1.time_ - var_246_8) / var_246_9)
				arg_243_1.mask_.color = var_246_10
			end

			if arg_243_1.time_ >= var_246_8 + var_246_9 and arg_243_1.time_ < var_246_8 + var_246_9 + arg_246_0 then
				local var_246_11 = Color.New(0, 0, 0)

				arg_243_1.mask_.enabled = false
				var_246_11.a = 0
				arg_243_1.mask_.color = var_246_11
			end

			local var_246_12 = arg_243_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_243_1.time_ and arg_243_1.time_ <= 1.96599999815226 + arg_246_0 then
				arg_243_1.var_.moveOldPos1089ui_story = var_246_12.localPosition
			end

			local var_246_13 = 0.001

			if 1.96599999815226 <= arg_243_1.time_ and arg_243_1.time_ < 1.96599999815226 + var_246_13 then
				var_246_12.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_243_1.time_ - 1.96599999815226) / var_246_13)
				var_246_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_12.position).x, (manager.ui.mainCamera.transform.position - var_246_12.position).y, (manager.ui.mainCamera.transform.position - var_246_12.position).z)
				var_246_12.localEulerAngles.z = 0
				var_246_12.localEulerAngles.x = 0
				var_246_12.localEulerAngles = var_246_12.localEulerAngles
			end

			if arg_243_1.time_ >= 1.96599999815226 + var_246_13 and arg_243_1.time_ < 1.96599999815226 + var_246_13 + arg_246_0 then
				var_246_12.localPosition = Vector3.New(0, 100, 0)
				var_246_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_246_12.position).x, (manager.ui.mainCamera.transform.position - var_246_12.position).y, (manager.ui.mainCamera.transform.position - var_246_12.position).z)
				var_246_12.localEulerAngles.z = 0
				var_246_12.localEulerAngles.x = 0
				var_246_12.localEulerAngles = var_246_12.localEulerAngles
			end

			local var_246_14 = arg_243_1.actors_["1089ui_story"]

			if 1.96599999815226 < arg_243_1.time_ and arg_243_1.time_ <= 1.96599999815226 + arg_246_0 and not isNil(var_246_14) and arg_243_1.var_.characterEffect1089ui_story == nil then
				arg_243_1.var_.characterEffect1089ui_story = var_246_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_15 = 0.034000001847744

			if 1.96599999815226 <= arg_243_1.time_ and arg_243_1.time_ < 1.96599999815226 + var_246_15 and not isNil(var_246_14) then
				if arg_243_1.var_.characterEffect1089ui_story and not isNil(var_246_14) then
					arg_243_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 1.96599999815226) / var_246_15)
				end
			end

			if arg_243_1.time_ >= 1.96599999815226 + var_246_15 and arg_243_1.time_ < 1.96599999815226 + var_246_15 + arg_246_0 and not isNil(var_246_14) and arg_243_1.var_.characterEffect1089ui_story then
				arg_243_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_246_16 = 2

			arg_243_1.isInRecall_ = false

			if var_246_16 < arg_243_1.time_ and arg_243_1.time_ <= var_246_16 + arg_246_0 then
				arg_243_1.screenFilterGo_:SetActive(false)

				for iter_246_2, iter_246_3 in pairs(arg_243_1.actors_) do
					for iter_246_4, iter_246_5 in ipairs((iter_246_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_246_5.color = iter_246_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_246_17 = 0.034000001847744

			if var_246_16 <= arg_243_1.time_ and arg_243_1.time_ < var_246_16 + var_246_17 then
				arg_243_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_243_1.time_ - var_246_16) / var_246_17)
			end

			if arg_243_1.time_ >= var_246_16 + var_246_17 and arg_243_1.time_ < var_246_16 + var_246_17 + arg_246_0 then
				arg_243_1.screenFilterEffect_.weight = 0
			end

			if 0.2 < arg_243_1.time_ and arg_243_1.time_ <= 0.2 + arg_246_0 then
				arg_243_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_data", "")
			end

			if 1.46666666666667 < arg_243_1.time_ and arg_243_1.time_ <= 1.46666666666667 + arg_246_0 then
				arg_243_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.83333333333333 < arg_243_1.time_ and arg_243_1.time_ <= 1.83333333333333 + arg_246_0 then
				if not isNil(arg_243_1.actors_["10103ui_story"]) then
					local var_246_20 = GameObjectTools.GetOrAddComponent(arg_243_1.actors_["10103ui_story"], typeof(DynamicBoneHelper))

					if var_246_20 then
						var_246_20:EnableDynamicBone(false)
					end
				end
			end

			if arg_243_1.frameCnt_ <= 1 then
				arg_243_1.dialog_:SetActive(false)
			end

			local var_246_21 = 4
			local var_246_22 = 0.775

			if 4 < arg_243_1.time_ and arg_243_1.time_ <= var_246_21 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0

				arg_243_1.dialog_:SetActive(true)

				arg_243_1.dialogCg_.alpha = 0

				local var_246_23 = LeanTween.value(arg_243_1.dialog_, 0, 1, 0.3)

				var_246_23:setOnUpdate(LuaHelper.FloatAction(function(arg_247_0)
					arg_243_1.dialogCg_.alpha = arg_247_0
				end))
				var_246_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_243_1.dialog_)
					var_246_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_243_1.duration_ = arg_243_1.duration_ + 0.3

				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_24 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(322151058).content)

				arg_243_1.text_.text = var_246_24

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_26 = 31 <= 0 and var_246_22 or var_246_22 * (utf8.len(var_246_24) / 31)

				if (31 <= 0 and var_246_22 or var_246_22 * (utf8.len(var_246_24) / 31)) > 0 and var_246_22 < var_246_26 then
					arg_243_1.talkMaxDuration = var_246_26
					var_246_21 = var_246_21 + 0.3

					if var_246_26 + var_246_21 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_26 + var_246_21
					end
				end

				arg_243_1.text_.text = var_246_24
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_27 = var_246_21 + 0.3
			local var_246_28 = math.max(var_246_22, arg_243_1.talkMaxDuration)

			if var_246_21 + 0.3 <= arg_243_1.time_ and arg_243_1.time_ < var_246_27 + var_246_28 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_27) / var_246_28

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_27 + var_246_28 and arg_243_1.time_ < var_246_27 + var_246_28 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play322151059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 322151059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play322151060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.55

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(322151059).content)

				arg_249_1.text_.text = var_252_1

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_3 = 22 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 22)

				if (22 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_1) / 22)) > 0 and var_252_0 < var_252_3 then
					arg_249_1.talkMaxDuration = var_252_3

					if var_252_3 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_3 + 0
					end
				end

				arg_249_1.text_.text = var_252_1
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_4 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_4

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play322151060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 322151060
		arg_253_1.duration_ = 8.33

		local var_253_0 = {
			zh = 5.733,
			ja = 8.333
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play322151061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos1020ui_story = arg_253_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).z)
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles = arg_253_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_253_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["1020ui_story"].transform.position).z)
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["1020ui_story"].transform.localEulerAngles = arg_253_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["1020ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1020ui_story == nil then
				arg_253_1.var_.characterEffect1020ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect1020ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect1020ui_story then
				arg_253_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				if arg_253_1.var_.characterEffect1020ui_story == nil then
					arg_253_1.var_.characterEffect1020ui_story = arg_253_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_256_4 = arg_253_1.var_.characterEffect1020ui_story

				arg_253_1.var_.characterEffect1020ui_story.imageEffect:turnOff()

				var_256_4.interferenceEffect.enabled = true
				var_256_4.interferenceEffect.noise = 0
				var_256_4.interferenceEffect.simTimeScale = 1
				var_256_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				if arg_253_1.var_.characterEffect1020ui_story == nil then
					arg_253_1.var_.characterEffect1020ui_story = arg_253_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_253_1.var_.characterEffect1020ui_story.imageEffect:turnOn(false)
			end

			local var_256_6 = 0
			local var_256_7 = 0.625

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_8 = arg_253_1:GetWordFromCfg(322151060)
				local var_256_9 = arg_253_1:FormatText(var_256_8.content)

				arg_253_1.text_.text = var_256_9

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 25 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 25)

				if (25 <= 0 and var_256_7 or var_256_7 * (utf8.len(var_256_9) / 25)) > 0 and var_256_7 < var_256_11 then
					arg_253_1.talkMaxDuration = var_256_11

					if var_256_11 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_11 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_9
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151060", "story_v_out_322151.awb") ~= 0 then
					local var_256_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151060", "story_v_out_322151.awb") / 1000

					if var_256_12 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_6
					end

					if var_256_8.prefab_name ~= "" and arg_253_1.actors_[var_256_8.prefab_name] ~= nil then
						local var_256_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_8.prefab_name].transform, "story_v_out_322151", "322151060", "story_v_out_322151.awb")

						arg_253_1:RecordAudio("322151060", var_256_13)
						arg_253_1:RecordAudio("322151060", var_256_13)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_322151", "322151060", "story_v_out_322151.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_322151", "322151060", "story_v_out_322151.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_14 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_14 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_14

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_14 and arg_253_1.time_ < var_256_6 + var_256_14 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play322151061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 322151061
		arg_257_1.duration_ = 8.03

		local var_257_0 = {
			zh = 6,
			ja = 8.033
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play322151062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos1020ui_story = arg_257_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).z)
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles = arg_257_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_257_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["1020ui_story"].transform.position).z)
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["1020ui_story"].transform.localEulerAngles = arg_257_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_2")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_260_1 = 0
			local var_260_2 = 0.725

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(322151061)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 29 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_4) / 29)

				if (29 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_4) / 29)) > 0 and var_260_2 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151061", "story_v_out_322151.awb") ~= 0 then
					local var_260_7 = manager.audio:GetVoiceLength("story_v_out_322151", "322151061", "story_v_out_322151.awb") / 1000

					if var_260_7 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_1
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_322151", "322151061", "story_v_out_322151.awb")

						arg_257_1:RecordAudio("322151061", var_260_8)
						arg_257_1:RecordAudio("322151061", var_260_8)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_322151", "322151061", "story_v_out_322151.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_322151", "322151061", "story_v_out_322151.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_9 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_9 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_9

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_9 and arg_257_1.time_ < var_260_1 + var_260_9 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play322151062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 322151062
		arg_261_1.duration_ = 9

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play322151063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if arg_261_1.bgs_.MS2209 == nil then
				local var_264_0 = Object.Instantiate(arg_261_1.paintGo_)

				var_264_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2209")
				var_264_0.name = "MS2209"
				var_264_0.transform.parent = arg_261_1.stage_.transform
				var_264_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.bgs_.MS2209 = var_264_0
			end

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				local var_264_1 = arg_261_1.bgs_.MS2209

				arg_261_1.bgs_.MS2209.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_264_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_264_2 = var_264_1:GetComponent("SpriteRenderer")

				if var_264_2 and var_264_2.sprite then
					local var_264_3 = 2 * (var_264_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_264_1.transform.localScale = Vector3.New(var_264_3 / var_264_2.sprite.bounds.size.y < var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x and var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x or var_264_3 / var_264_2.sprite.bounds.size.y, var_264_3 / var_264_2.sprite.bounds.size.y < var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x and var_264_3 * manager.ui.mainCameraCom_.aspect / var_264_2.sprite.bounds.size.x or var_264_3 / var_264_2.sprite.bounds.size.y, 0)
				end

				for iter_264_0, iter_264_1 in pairs(arg_261_1.bgs_) do
					if iter_264_0 ~= "MS2209" then
						iter_264_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_264_4 = 3.999999999999

			if 3.999999999999 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.allBtn_.enabled = false
			end

			if arg_261_1.time_ >= var_264_4 + 0.3 and arg_261_1.time_ < var_264_4 + 0.3 + arg_264_0 then
				arg_261_1.allBtn_.enabled = true
			end

			local var_264_5 = 0

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_6 = 2

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_6 then
				local var_264_7 = Color.New(0, 0, 0)

				var_264_7.a = Mathf.Lerp(0, 1, (arg_261_1.time_ - var_264_5) / var_264_6)
				arg_261_1.mask_.color = var_264_7
			end

			if arg_261_1.time_ >= var_264_5 + var_264_6 and arg_261_1.time_ < var_264_5 + var_264_6 + arg_264_0 then
				local var_264_8 = Color.New(0, 0, 0)

				var_264_8.a = 1
				arg_261_1.mask_.color = var_264_8
			end

			local var_264_9 = 2

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= var_264_9 + arg_264_0 then
				arg_261_1.mask_.enabled = true
				arg_261_1.mask_.raycastTarget = true

				arg_261_1:SetGaussion(false)
			end

			local var_264_10 = 2

			if var_264_9 <= arg_261_1.time_ and arg_261_1.time_ < var_264_9 + var_264_10 then
				local var_264_11 = Color.New(0, 0, 0)

				var_264_11.a = Mathf.Lerp(1, 0, (arg_261_1.time_ - var_264_9) / var_264_10)
				arg_261_1.mask_.color = var_264_11
			end

			if arg_261_1.time_ >= var_264_9 + var_264_10 and arg_261_1.time_ < var_264_9 + var_264_10 + arg_264_0 then
				local var_264_12 = Color.New(0, 0, 0)

				arg_261_1.mask_.enabled = false
				var_264_12.a = 0
				arg_261_1.mask_.color = var_264_12
			end

			local var_264_13 = arg_261_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_261_1.time_ and arg_261_1.time_ <= 1.96599999815226 + arg_264_0 then
				arg_261_1.var_.moveOldPos1020ui_story = var_264_13.localPosition
			end

			local var_264_14 = 0.001

			if 1.96599999815226 <= arg_261_1.time_ and arg_261_1.time_ < 1.96599999815226 + var_264_14 then
				var_264_13.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 1.96599999815226) / var_264_14)
				var_264_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_13.position).x, (manager.ui.mainCamera.transform.position - var_264_13.position).y, (manager.ui.mainCamera.transform.position - var_264_13.position).z)
				var_264_13.localEulerAngles.z = 0
				var_264_13.localEulerAngles.x = 0
				var_264_13.localEulerAngles = var_264_13.localEulerAngles
			end

			if arg_261_1.time_ >= 1.96599999815226 + var_264_14 and arg_261_1.time_ < 1.96599999815226 + var_264_14 + arg_264_0 then
				var_264_13.localPosition = Vector3.New(0, 100, 0)
				var_264_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_13.position).x, (manager.ui.mainCamera.transform.position - var_264_13.position).y, (manager.ui.mainCamera.transform.position - var_264_13.position).z)
				var_264_13.localEulerAngles.z = 0
				var_264_13.localEulerAngles.x = 0
				var_264_13.localEulerAngles = var_264_13.localEulerAngles
			end

			if 0.233333333333333 < arg_261_1.time_ and arg_261_1.time_ <= 0.233333333333333 + arg_264_0 then
				arg_261_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 1.56666666666667 < arg_261_1.time_ and arg_261_1.time_ <= 1.56666666666667 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 4.4 < arg_261_1.time_ and arg_261_1.time_ <= 4.4 + arg_264_0 then
				arg_261_1:AudioAction("play", "effect", "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			local var_264_18 = arg_261_1.bgs_.MS2209.transform

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				arg_261_1.var_.moveOldPosMS2209 = var_264_18.localPosition
			end

			local var_264_19 = 0.001

			if 2 <= arg_261_1.time_ and arg_261_1.time_ < 2 + var_264_19 then
				var_264_18.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosMS2209, Vector3.New(0, 1, 10), (arg_261_1.time_ - 2) / var_264_19)
			end

			if arg_261_1.time_ >= 2 + var_264_19 and arg_261_1.time_ < 2 + var_264_19 + arg_264_0 then
				var_264_18.localPosition = Vector3.New(0, 1, 10)
			end

			local var_264_20 = arg_261_1.bgs_.MS2209.transform

			if 2.034 < arg_261_1.time_ and arg_261_1.time_ <= 2.034 + arg_264_0 then
				arg_261_1.var_.moveOldPosMS2209 = var_264_20.localPosition
			end

			local var_264_21 = 1.966

			if 2.034 <= arg_261_1.time_ and arg_261_1.time_ < 2.034 + var_264_21 then
				var_264_20.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPosMS2209, Vector3.New(0.4, 1.5, 5), (arg_261_1.time_ - 2.034) / var_264_21)
			end

			if arg_261_1.time_ >= 2.034 + var_264_21 and arg_261_1.time_ < 2.034 + var_264_21 + arg_264_0 then
				var_264_20.localPosition = Vector3.New(0.4, 1.5, 5)
			end

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				if arg_261_1.var_.characterEffect1020ui_story == nil then
					arg_261_1.var_.characterEffect1020ui_story = arg_261_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_264_22 = arg_261_1.var_.characterEffect1020ui_story

				arg_261_1.var_.characterEffect1020ui_story.imageEffect:turnOff()

				var_264_22.interferenceEffect.enabled = false
				var_264_22.interferenceEffect.noise = 0
				var_264_22.interferenceEffect.simTimeScale = 1
				var_264_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 2 < arg_261_1.time_ and arg_261_1.time_ <= 2 + arg_264_0 then
				if arg_261_1.var_.characterEffect1020ui_story == nil then
					arg_261_1.var_.characterEffect1020ui_story = arg_261_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_261_1.var_.characterEffect1020ui_story.imageEffect:turnOff()
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_264_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_261_1.bgmTxt_.text ~= var_264_26 and arg_261_1.bgmTxt_.text ~= "" then
						if arg_261_1.bgmTxt2_.text ~= "" then
							arg_261_1.bgmTxt_.text = arg_261_1.bgmTxt2_.text
						end

						arg_261_1.bgmTxt2_.text = var_264_26

						arg_261_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_261_1.bgmTxt_.text = var_264_26
						arg_261_1.bgmTxt2_.text = var_264_26
					end

					if arg_261_1.bgmTimer then
						arg_261_1.bgmTimer:Stop()

						arg_261_1.bgmTimer = nil
					end

					if arg_261_1.settingData.show_music_name == 1 then
						arg_261_1.musicController:SetSelectedState("show")
						arg_261_1.musicAnimator_:Play("open", 0, 0)

						if arg_261_1.settingData.music_time ~= 0 then
							arg_261_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_261_1.settingData.music_time), function()
								if arg_261_1 == nil or isNil(arg_261_1.bgmTxt_) then
									return
								end

								arg_261_1.musicController:SetSelectedState("hide")
								arg_261_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.566666666666667 < arg_261_1.time_ and arg_261_1.time_ <= 0.566666666666667 + arg_264_0 then
				arg_261_1:AudioAction("play", "music", "bgm_activity_4_5_story_MS2209", "bgm_activity_4_5_story_MS2209", "bgm_activity_4_5_story_MS2209.awb")

				local var_264_29 = manager.audio:GetAudioName("bgm_activity_4_5_story_MS2209", "bgm_activity_4_5_story_MS2209")

				if "" ~= "" then
					if arg_261_1.bgmTxt_.text ~= var_264_29 and arg_261_1.bgmTxt_.text ~= "" then
						if arg_261_1.bgmTxt2_.text ~= "" then
							arg_261_1.bgmTxt_.text = arg_261_1.bgmTxt2_.text
						end

						arg_261_1.bgmTxt2_.text = var_264_29

						arg_261_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_261_1.bgmTxt_.text = var_264_29
						arg_261_1.bgmTxt2_.text = var_264_29
					end

					if arg_261_1.bgmTimer then
						arg_261_1.bgmTimer:Stop()

						arg_261_1.bgmTimer = nil
					end

					if arg_261_1.settingData.show_music_name == 1 then
						arg_261_1.musicController:SetSelectedState("show")
						arg_261_1.musicAnimator_:Play("open", 0, 0)

						if arg_261_1.settingData.music_time ~= 0 then
							arg_261_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_261_1.settingData.music_time), function()
								if arg_261_1 == nil or isNil(arg_261_1.bgmTxt_) then
									return
								end

								arg_261_1.musicController:SetSelectedState("hide")
								arg_261_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_261_1.frameCnt_ <= 1 then
				arg_261_1.dialog_:SetActive(false)
			end

			local var_264_30 = 3.999999999999
			local var_264_31 = 1.025

			if 3.999999999999 < arg_261_1.time_ and arg_261_1.time_ <= var_264_30 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0

				arg_261_1.dialog_:SetActive(true)

				arg_261_1.dialogCg_.alpha = 0

				local var_264_32 = LeanTween.value(arg_261_1.dialog_, 0, 1, 0.3)

				var_264_32:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_261_1.dialogCg_.alpha = arg_267_0
				end))
				var_264_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_261_1.dialog_)
					var_264_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_261_1.duration_ = arg_261_1.duration_ + 0.3

				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_33 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(322151062).content)

				arg_261_1.text_.text = var_264_33

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_35 = 41 <= 0 and var_264_31 or var_264_31 * (utf8.len(var_264_33) / 41)

				if (41 <= 0 and var_264_31 or var_264_31 * (utf8.len(var_264_33) / 41)) > 0 and var_264_31 < var_264_35 then
					arg_261_1.talkMaxDuration = var_264_35
					var_264_30 = var_264_30 + 0.3

					if var_264_35 + var_264_30 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_35 + var_264_30
					end
				end

				arg_261_1.text_.text = var_264_33
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_36 = var_264_30 + 0.3
			local var_264_37 = math.max(var_264_31, arg_261_1.talkMaxDuration)

			if var_264_30 + 0.3 <= arg_261_1.time_ and arg_261_1.time_ < var_264_36 + var_264_37 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_36) / var_264_37

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_36 + var_264_37 and arg_261_1.time_ < var_264_36 + var_264_37 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "MS2209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.966,
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.4, 1, 6),
					endPos = Vector3.New(0.4, 1.5, 5),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play322151063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 322151063
		arg_269_1.duration_ = 3.57

		local var_269_0 = {
			zh = 1.866,
			ja = 3.566
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play322151064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.2

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(322151063)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 8 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 8)

				if (8 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 8)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151063", "story_v_out_322151.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151063", "story_v_out_322151.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_322151", "322151063", "story_v_out_322151.awb")

						arg_269_1:RecordAudio("322151063", var_272_6)
						arg_269_1:RecordAudio("322151063", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_322151", "322151063", "story_v_out_322151.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_322151", "322151063", "story_v_out_322151.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play322151064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 322151064
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play322151065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.7

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(322151064).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 28 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 28)

				if (28 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 28)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play322151065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 322151065
		arg_277_1.duration_ = 8.97

		local var_277_0 = {
			zh = 7.533,
			ja = 8.966
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play322151066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.7

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(322151065)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 28 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 28)

				if (28 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 28)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151065", "story_v_out_322151.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151065", "story_v_out_322151.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_322151", "322151065", "story_v_out_322151.awb")

						arg_277_1:RecordAudio("322151065", var_280_6)
						arg_277_1:RecordAudio("322151065", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_322151", "322151065", "story_v_out_322151.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_322151", "322151065", "story_v_out_322151.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play322151066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 322151066
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play322151067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.4

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(322151066).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 16 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 16)

				if (16 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 16)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play322151067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 322151067
		arg_285_1.duration_ = 8

		local var_285_0 = {
			zh = 7.633,
			ja = 8
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play322151068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 1.025

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:GetWordFromCfg(322151067)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 41 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 41)

				if (41 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 41)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151067", "story_v_out_322151.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151067", "story_v_out_322151.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_322151", "322151067", "story_v_out_322151.awb")

						arg_285_1:RecordAudio("322151067", var_288_6)
						arg_285_1:RecordAudio("322151067", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_322151", "322151067", "story_v_out_322151.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_322151", "322151067", "story_v_out_322151.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play322151068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 322151068
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play322151069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.275

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(322151068).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 11 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 11)

				if (11 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 11)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play322151069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 322151069
		arg_293_1.duration_ = 6.1

		local var_293_0 = {
			zh = 6.1,
			ja = 5.7
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play322151070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.7

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:GetWordFromCfg(322151069)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 28 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 28)

				if (28 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 28)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151069", "story_v_out_322151.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151069", "story_v_out_322151.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_322151", "322151069", "story_v_out_322151.awb")

						arg_293_1:RecordAudio("322151069", var_296_6)
						arg_293_1:RecordAudio("322151069", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_322151", "322151069", "story_v_out_322151.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_322151", "322151069", "story_v_out_322151.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play322151070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 322151070
		arg_297_1.duration_ = 11.7

		local var_297_0 = {
			zh = 8.4,
			ja = 11.7
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play322151071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.025

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:GetWordFromCfg(322151070)
				local var_300_2 = arg_297_1:FormatText(var_300_1.content)

				arg_297_1.text_.text = var_300_2

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 41 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 41)

				if (41 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 41)) > 0 and var_300_0 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end

				arg_297_1.text_.text = var_300_2
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151070", "story_v_out_322151.awb") ~= 0 then
					local var_300_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151070", "story_v_out_322151.awb") / 1000

					if var_300_5 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + 0
					end

					if var_300_1.prefab_name ~= "" and arg_297_1.actors_[var_300_1.prefab_name] ~= nil then
						local var_300_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_1.prefab_name].transform, "story_v_out_322151", "322151070", "story_v_out_322151.awb")

						arg_297_1:RecordAudio("322151070", var_300_6)
						arg_297_1:RecordAudio("322151070", var_300_6)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_322151", "322151070", "story_v_out_322151.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_322151", "322151070", "story_v_out_322151.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play322151071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 322151071
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play322151072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.275

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(322151071).content)

				arg_301_1.text_.text = var_304_1

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_3 = 11 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 11)

				if (11 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_1) / 11)) > 0 and var_304_0 < var_304_3 then
					arg_301_1.talkMaxDuration = var_304_3

					if var_304_3 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_3 + 0
					end
				end

				arg_301_1.text_.text = var_304_1
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_4 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_4

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play322151072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 322151072
		arg_305_1.duration_ = 6.43

		local var_305_0 = {
			zh = 5.866,
			ja = 6.433
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play322151073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.55

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_1 = arg_305_1:GetWordFromCfg(322151072)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 22 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 22)

				if (22 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 22)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151072", "story_v_out_322151.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151072", "story_v_out_322151.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_out_322151", "322151072", "story_v_out_322151.awb")

						arg_305_1:RecordAudio("322151072", var_308_6)
						arg_305_1:RecordAudio("322151072", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_322151", "322151072", "story_v_out_322151.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_322151", "322151072", "story_v_out_322151.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_0, arg_305_1.talkMaxDuration)

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - 0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= 0 + var_308_7 and arg_305_1.time_ < 0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play322151073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 322151073
		arg_309_1.duration_ = 8.23

		local var_309_0 = {
			zh = 7.466,
			ja = 8.233
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play322151074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0.775

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_1 = arg_309_1:GetWordFromCfg(322151073)
				local var_312_2 = arg_309_1:FormatText(var_312_1.content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 31 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 31)

				if (31 <= 0 and var_312_0 or var_312_0 * (utf8.len(var_312_2) / 31)) > 0 and var_312_0 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + 0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151073", "story_v_out_322151.awb") ~= 0 then
					local var_312_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151073", "story_v_out_322151.awb") / 1000

					if var_312_5 + 0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + 0
					end

					if var_312_1.prefab_name ~= "" and arg_309_1.actors_[var_312_1.prefab_name] ~= nil then
						local var_312_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_1.prefab_name].transform, "story_v_out_322151", "322151073", "story_v_out_322151.awb")

						arg_309_1:RecordAudio("322151073", var_312_6)
						arg_309_1:RecordAudio("322151073", var_312_6)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_322151", "322151073", "story_v_out_322151.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_322151", "322151073", "story_v_out_322151.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_7 = math.max(var_312_0, arg_309_1.talkMaxDuration)

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_7 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - 0) / var_312_7

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= 0 + var_312_7 and arg_309_1.time_ < 0 + var_312_7 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play322151074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 322151074
		arg_313_1.duration_ = 15.5

		local var_313_0 = {
			zh = 6.966,
			ja = 15.5
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play322151075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.775

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:GetWordFromCfg(322151074)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 31 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 31)

				if (31 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 31)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151074", "story_v_out_322151.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151074", "story_v_out_322151.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_322151", "322151074", "story_v_out_322151.awb")

						arg_313_1:RecordAudio("322151074", var_316_6)
						arg_313_1:RecordAudio("322151074", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_322151", "322151074", "story_v_out_322151.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_322151", "322151074", "story_v_out_322151.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play322151075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 322151075
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play322151076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0.65

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(322151075).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 26 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 26)

				if (26 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 26)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play322151076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 322151076
		arg_321_1.duration_ = 5.17

		local var_321_0 = {
			zh = 3.833,
			ja = 5.166
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play322151077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.4

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(322151076)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 16 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 16)

				if (16 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 16)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151076", "story_v_out_322151.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151076", "story_v_out_322151.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_322151", "322151076", "story_v_out_322151.awb")

						arg_321_1:RecordAudio("322151076", var_324_6)
						arg_321_1:RecordAudio("322151076", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_322151", "322151076", "story_v_out_322151.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_322151", "322151076", "story_v_out_322151.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play322151077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 322151077
		arg_325_1.duration_ = 6

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play322151078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPosMS2209 = arg_325_1.bgs_.MS2209.transform.localPosition
			end

			local var_328_0 = 1

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.bgs_.MS2209.transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPosMS2209, Vector3.New(0, 1, 10), (arg_325_1.time_ - 0) / var_328_0)
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.bgs_.MS2209.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_328_1 = 0

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.allBtn_.enabled = false
			end

			if arg_325_1.time_ >= var_328_1 + 2.85833333333333 and arg_325_1.time_ < var_328_1 + 2.85833333333333 + arg_328_0 then
				arg_325_1.allBtn_.enabled = true
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_2 = 1
			local var_328_3 = 1.175

			if 1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_4 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_4:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_5 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(322151077).content)

				arg_325_1.text_.text = var_328_5

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_7 = 47 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 47)

				if (47 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_5) / 47)) > 0 and var_328_3 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7
					var_328_2 = var_328_2 + 0.3

					if var_328_7 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_5
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_8 = var_328_2 + 0.3
			local var_328_9 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 + 0.3 <= arg_325_1.time_ and arg_325_1.time_ < var_328_8 + var_328_9 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_8) / var_328_9

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_8 + var_328_9 and arg_325_1.time_ < var_328_8 + var_328_9 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play322151078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 322151078
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play322151079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 0.775

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(322151078).content)

				arg_331_1.text_.text = var_334_1

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_3 = 31 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 31)

				if (31 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_1) / 31)) > 0 and var_334_0 < var_334_3 then
					arg_331_1.talkMaxDuration = var_334_3

					if var_334_3 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_3 + 0
					end
				end

				arg_331_1.text_.text = var_334_1
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_4 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_4

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play322151079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 322151079
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play322151080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 1

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(322151079).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 40 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 40)

				if (40 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 40)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play322151080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 322151080
		arg_339_1.duration_ = 7

		local var_339_0 = {
			zh = 5.466,
			ja = 7
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play322151081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.55

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_1 = arg_339_1:GetWordFromCfg(322151080)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 22 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 22)

				if (22 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 22)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151080", "story_v_out_322151.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151080", "story_v_out_322151.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_322151", "322151080", "story_v_out_322151.awb")

						arg_339_1:RecordAudio("322151080", var_342_6)
						arg_339_1:RecordAudio("322151080", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_322151", "322151080", "story_v_out_322151.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_322151", "322151080", "story_v_out_322151.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play322151081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 322151081
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play322151082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.3

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(322151081).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 12 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 12)

				if (12 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 12)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play322151082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 322151082
		arg_347_1.duration_ = 3.53

		local var_347_0 = {
			zh = 1.5,
			ja = 3.533
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play322151083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0.175

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_1 = arg_347_1:GetWordFromCfg(322151082)
				local var_350_2 = arg_347_1:FormatText(var_350_1.content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 7 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 7)

				if (7 <= 0 and var_350_0 or var_350_0 * (utf8.len(var_350_2) / 7)) > 0 and var_350_0 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + 0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151082", "story_v_out_322151.awb") ~= 0 then
					local var_350_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151082", "story_v_out_322151.awb") / 1000

					if var_350_5 + 0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + 0
					end

					if var_350_1.prefab_name ~= "" and arg_347_1.actors_[var_350_1.prefab_name] ~= nil then
						local var_350_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_1.prefab_name].transform, "story_v_out_322151", "322151082", "story_v_out_322151.awb")

						arg_347_1:RecordAudio("322151082", var_350_6)
						arg_347_1:RecordAudio("322151082", var_350_6)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_322151", "322151082", "story_v_out_322151.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_322151", "322151082", "story_v_out_322151.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_7 = math.max(var_350_0, arg_347_1.talkMaxDuration)

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - 0) / var_350_7

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play322151083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 322151083
		arg_351_1.duration_ = 5

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play322151084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0.675

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(322151083).content)

				arg_351_1.text_.text = var_354_1

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_3 = 27 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 27)

				if (27 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_1) / 27)) > 0 and var_354_0 < var_354_3 then
					arg_351_1.talkMaxDuration = var_354_3

					if var_354_3 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_3 + 0
					end
				end

				arg_351_1.text_.text = var_354_1
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_4 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_4

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play322151084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 322151084
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play322151085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0.975

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_1 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(322151084).content)

				arg_355_1.text_.text = var_358_1

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_3 = 39 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 39)

				if (39 <= 0 and var_358_0 or var_358_0 * (utf8.len(var_358_1) / 39)) > 0 and var_358_0 < var_358_3 then
					arg_355_1.talkMaxDuration = var_358_3

					if var_358_3 + 0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_3 + 0
					end
				end

				arg_355_1.text_.text = var_358_1
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_4 = math.max(var_358_0, arg_355_1.talkMaxDuration)

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - 0) / var_358_4

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play322151085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 322151085
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play322151086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.85

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(322151085).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 34 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 34)

				if (34 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 34)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play322151086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 322151086
		arg_363_1.duration_ = 6.43

		local var_363_0 = {
			zh = 4.166,
			ja = 6.433
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play322151087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.625

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:GetWordFromCfg(322151086)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 25 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 25)

				if (25 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 25)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151086", "story_v_out_322151.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151086", "story_v_out_322151.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_322151", "322151086", "story_v_out_322151.awb")

						arg_363_1:RecordAudio("322151086", var_366_6)
						arg_363_1:RecordAudio("322151086", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_322151", "322151086", "story_v_out_322151.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_322151", "322151086", "story_v_out_322151.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play322151087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 322151087
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play322151088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.225

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(322151087).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 9 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 9)

				if (9 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 9)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play322151088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 322151088
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play322151089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1.275

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(322151088).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 51 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 51)

				if (51 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 51)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play322151089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 322151089
		arg_375_1.duration_ = 10.2

		local var_375_0 = {
			zh = 7.366,
			ja = 10.2
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play322151090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.725

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:GetWordFromCfg(322151089)
				local var_378_2 = arg_375_1:FormatText(var_378_1.content)

				arg_375_1.text_.text = var_378_2

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 29 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 29)

				if (29 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 29)) > 0 and var_378_0 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end

				arg_375_1.text_.text = var_378_2
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151089", "story_v_out_322151.awb") ~= 0 then
					local var_378_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151089", "story_v_out_322151.awb") / 1000

					if var_378_5 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + 0
					end

					if var_378_1.prefab_name ~= "" and arg_375_1.actors_[var_378_1.prefab_name] ~= nil then
						local var_378_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_1.prefab_name].transform, "story_v_out_322151", "322151089", "story_v_out_322151.awb")

						arg_375_1:RecordAudio("322151089", var_378_6)
						arg_375_1:RecordAudio("322151089", var_378_6)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_322151", "322151089", "story_v_out_322151.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_322151", "322151089", "story_v_out_322151.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play322151090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 322151090
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play322151091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.35

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(322151090).content)

				arg_379_1.text_.text = var_382_1

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_3 = 14 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 14)

				if (14 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 14)) > 0 and var_382_0 < var_382_3 then
					arg_379_1.talkMaxDuration = var_382_3

					if var_382_3 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_3 + 0
					end
				end

				arg_379_1.text_.text = var_382_1
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_4 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_4

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play322151091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 322151091
		arg_383_1.duration_ = 4.43

		local var_383_0 = {
			zh = 1.966,
			ja = 4.433
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play322151092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.275

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:GetWordFromCfg(322151091)
				local var_386_2 = arg_383_1:FormatText(var_386_1.content)

				arg_383_1.text_.text = var_386_2

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 11 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 11)

				if (11 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_2) / 11)) > 0 and var_386_0 < var_386_4 then
					arg_383_1.talkMaxDuration = var_386_4

					if var_386_4 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_4 + 0
					end
				end

				arg_383_1.text_.text = var_386_2
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151091", "story_v_out_322151.awb") ~= 0 then
					local var_386_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151091", "story_v_out_322151.awb") / 1000

					if var_386_5 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + 0
					end

					if var_386_1.prefab_name ~= "" and arg_383_1.actors_[var_386_1.prefab_name] ~= nil then
						local var_386_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_1.prefab_name].transform, "story_v_out_322151", "322151091", "story_v_out_322151.awb")

						arg_383_1:RecordAudio("322151091", var_386_6)
						arg_383_1:RecordAudio("322151091", var_386_6)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_322151", "322151091", "story_v_out_322151.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_322151", "322151091", "story_v_out_322151.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_7 and arg_383_1.time_ < 0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play322151092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 322151092
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play322151093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 1.1

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(322151092).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 44 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 44)

				if (44 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 44)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play322151093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 322151093
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play322151094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 1.65

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(322151093).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 66 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 66)

				if (66 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 66)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play322151094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 322151094
		arg_395_1.duration_ = 5

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play322151095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 1.15

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:FormatText(arg_395_1:GetWordFromCfg(322151094).content)

				arg_395_1.text_.text = var_398_1

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_3 = 46 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 46)

				if (46 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_1) / 46)) > 0 and var_398_0 < var_398_3 then
					arg_395_1.talkMaxDuration = var_398_3

					if var_398_3 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_3 + 0
					end
				end

				arg_395_1.text_.text = var_398_1
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)
				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_4 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_4 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_4

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_4 and arg_395_1.time_ < 0 + var_398_4 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play322151095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 322151095
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play322151096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.925

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(322151095).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 37 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 37)

				if (37 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 37)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play322151096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 322151096
		arg_403_1.duration_ = 10.7

		local var_403_0 = {
			zh = 8.366,
			ja = 10.7
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play322151097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if arg_403_1.bgs_.ST0504 == nil then
				local var_406_0 = Object.Instantiate(arg_403_1.paintGo_)

				var_406_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0504")
				var_406_0.name = "ST0504"
				var_406_0.transform.parent = arg_403_1.stage_.transform
				var_406_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.bgs_.ST0504 = var_406_0
			end

			if 2.00000000298023 < arg_403_1.time_ and arg_403_1.time_ <= 2.00000000298023 + arg_406_0 then
				local var_406_1 = arg_403_1.bgs_.ST0504

				arg_403_1.bgs_.ST0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_406_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_406_2 = var_406_1:GetComponent("SpriteRenderer")

				if var_406_2 and var_406_2.sprite then
					local var_406_3 = 2 * (var_406_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_406_1.transform.localScale = Vector3.New(var_406_3 / var_406_2.sprite.bounds.size.y < var_406_3 * manager.ui.mainCameraCom_.aspect / var_406_2.sprite.bounds.size.x and var_406_3 * manager.ui.mainCameraCom_.aspect / var_406_2.sprite.bounds.size.x or var_406_3 / var_406_2.sprite.bounds.size.y, var_406_3 / var_406_2.sprite.bounds.size.y < var_406_3 * manager.ui.mainCameraCom_.aspect / var_406_2.sprite.bounds.size.x and var_406_3 * manager.ui.mainCameraCom_.aspect / var_406_2.sprite.bounds.size.x or var_406_3 / var_406_2.sprite.bounds.size.y, 0)
				end

				for iter_406_0, iter_406_1 in pairs(arg_403_1.bgs_) do
					if iter_406_0 ~= "ST0504" then
						iter_406_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_406_4 = 0

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_5 = 2

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_5 then
				local var_406_6 = Color.New(0, 0, 0)

				var_406_6.a = Mathf.Lerp(0, 1, (arg_403_1.time_ - var_406_4) / var_406_5)
				arg_403_1.mask_.color = var_406_6
			end

			if arg_403_1.time_ >= var_406_4 + var_406_5 and arg_403_1.time_ < var_406_4 + var_406_5 + arg_406_0 then
				local var_406_7 = Color.New(0, 0, 0)

				var_406_7.a = 1
				arg_403_1.mask_.color = var_406_7
			end

			local var_406_8 = 2

			if 2 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_9 = 2

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_9 then
				local var_406_10 = Color.New(0, 0, 0)

				var_406_10.a = Mathf.Lerp(1, 0, (arg_403_1.time_ - var_406_8) / var_406_9)
				arg_403_1.mask_.color = var_406_10
			end

			if arg_403_1.time_ >= var_406_8 + var_406_9 and arg_403_1.time_ < var_406_8 + var_406_9 + arg_406_0 then
				local var_406_11 = Color.New(0, 0, 0)

				arg_403_1.mask_.enabled = false
				var_406_11.a = 0
				arg_403_1.mask_.color = var_406_11
			end

			local var_406_12 = arg_403_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_403_1.time_ and arg_403_1.time_ <= 1.96599999815226 + arg_406_0 then
				arg_403_1.var_.moveOldPos1020ui_story = var_406_12.localPosition
			end

			local var_406_13 = 0.001

			if 1.96599999815226 <= arg_403_1.time_ and arg_403_1.time_ < 1.96599999815226 + var_406_13 then
				var_406_12.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_403_1.time_ - 1.96599999815226) / var_406_13)
				var_406_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_12.position).x, (manager.ui.mainCamera.transform.position - var_406_12.position).y, (manager.ui.mainCamera.transform.position - var_406_12.position).z)
				var_406_12.localEulerAngles.z = 0
				var_406_12.localEulerAngles.x = 0
				var_406_12.localEulerAngles = var_406_12.localEulerAngles
			end

			if arg_403_1.time_ >= 1.96599999815226 + var_406_13 and arg_403_1.time_ < 1.96599999815226 + var_406_13 + arg_406_0 then
				var_406_12.localPosition = Vector3.New(0, 100, 0)
				var_406_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_12.position).x, (manager.ui.mainCamera.transform.position - var_406_12.position).y, (manager.ui.mainCamera.transform.position - var_406_12.position).z)
				var_406_12.localEulerAngles.z = 0
				var_406_12.localEulerAngles.x = 0
				var_406_12.localEulerAngles = var_406_12.localEulerAngles
			end

			local var_406_14 = "1029ui_story"

			if arg_403_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_406_15 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_403_1.stage_.transform)

				var_406_15.name = var_406_14
				var_406_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_403_1.actors_[var_406_14] = var_406_15

				local var_406_16 = var_406_15:GetComponentInChildren(typeof(CharacterEffect))

				var_406_16.enabled = true

				local var_406_17 = GameObjectTools.GetOrAddComponent(var_406_15, typeof(DynamicBoneHelper))

				if var_406_17 then
					var_406_17:EnableDynamicBone(false)
				end

				arg_403_1:ShowWeapon(var_406_16.transform, false)

				arg_403_1.var_[var_406_14 .. "Animator"] = var_406_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_403_1.var_[var_406_14 .. "Animator"].applyRootMotion = true
				arg_403_1.var_[var_406_14 .. "LipSync"] = var_406_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_406_18 = arg_403_1.actors_["1029ui_story"].transform

			if 3.8 < arg_403_1.time_ and arg_403_1.time_ <= 3.8 + arg_406_0 then
				arg_403_1.var_.moveOldPos1029ui_story = var_406_18.localPosition
			end

			local var_406_19 = 0.001

			if 3.8 <= arg_403_1.time_ and arg_403_1.time_ < 3.8 + var_406_19 then
				var_406_18.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_403_1.time_ - 3.8) / var_406_19)
				var_406_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_18.position).x, (manager.ui.mainCamera.transform.position - var_406_18.position).y, (manager.ui.mainCamera.transform.position - var_406_18.position).z)
				var_406_18.localEulerAngles.z = 0
				var_406_18.localEulerAngles.x = 0
				var_406_18.localEulerAngles = var_406_18.localEulerAngles
			end

			if arg_403_1.time_ >= 3.8 + var_406_19 and arg_403_1.time_ < 3.8 + var_406_19 + arg_406_0 then
				var_406_18.localPosition = Vector3.New(0, -1.09, -6.2)
				var_406_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_406_18.position).x, (manager.ui.mainCamera.transform.position - var_406_18.position).y, (manager.ui.mainCamera.transform.position - var_406_18.position).z)
				var_406_18.localEulerAngles.z = 0
				var_406_18.localEulerAngles.x = 0
				var_406_18.localEulerAngles = var_406_18.localEulerAngles
			end

			local var_406_20 = arg_403_1.actors_["1029ui_story"]

			if 3.8 < arg_403_1.time_ and arg_403_1.time_ <= 3.8 + arg_406_0 and not isNil(var_406_20) and arg_403_1.var_.characterEffect1029ui_story == nil then
				arg_403_1.var_.characterEffect1029ui_story = var_406_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_21 = 0.200000002980232

			if 3.8 <= arg_403_1.time_ and arg_403_1.time_ < 3.8 + var_406_21 and not isNil(var_406_20) then
				if arg_403_1.var_.characterEffect1029ui_story and not isNil(var_406_20) then
					arg_403_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= 3.8 + var_406_21 and arg_403_1.time_ < 3.8 + var_406_21 + arg_406_0 and not isNil(var_406_20) and arg_403_1.var_.characterEffect1029ui_story then
				arg_403_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 3.8 < arg_403_1.time_ and arg_403_1.time_ <= 3.8 + arg_406_0 then
				arg_403_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 3.8 < arg_403_1.time_ and arg_403_1.time_ <= 3.8 + arg_406_0 then
				arg_403_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_406_23 = 2.00000000298023

			arg_403_1.isInRecall_ = false

			if var_406_23 < arg_403_1.time_ and arg_403_1.time_ <= var_406_23 + arg_406_0 then
				arg_403_1.screenFilterGo_:SetActive(true)

				arg_403_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_406_2, iter_406_3 in pairs(arg_403_1.actors_) do
					for iter_406_4, iter_406_5 in ipairs((iter_406_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_406_5.color = iter_406_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_406_24 = 0.0166666666666667

			if var_406_23 <= arg_403_1.time_ and arg_403_1.time_ < var_406_23 + var_406_24 then
				arg_403_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_403_1.time_ - var_406_23) / var_406_24)
			end

			if arg_403_1.time_ >= var_406_23 + var_406_24 and arg_403_1.time_ < var_406_23 + var_406_24 + arg_406_0 then
				arg_403_1.screenFilterEffect_.weight = 1
			end

			if 0.3 < arg_403_1.time_ and arg_403_1.time_ <= 0.3 + arg_406_0 then
				arg_403_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 1.56666666666667 < arg_403_1.time_ and arg_403_1.time_ <= 1.56666666666667 + arg_406_0 then
				arg_403_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_403_1.frameCnt_ <= 1 then
				arg_403_1.dialog_:SetActive(false)
			end

			local var_406_27 = 4
			local var_406_28 = 0.375

			if 4 < arg_403_1.time_ and arg_403_1.time_ <= var_406_27 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0

				arg_403_1.dialog_:SetActive(true)

				arg_403_1.dialogCg_.alpha = 0

				local var_406_29 = LeanTween.value(arg_403_1.dialog_, 0, 1, 0.3)

				var_406_29:setOnUpdate(LuaHelper.FloatAction(function(arg_407_0)
					arg_403_1.dialogCg_.alpha = arg_407_0
				end))
				var_406_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_403_1.dialog_)
					var_406_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_403_1.duration_ = arg_403_1.duration_ + 0.3

				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_30 = arg_403_1:GetWordFromCfg(322151096)
				local var_406_31 = arg_403_1:FormatText(var_406_30.content)

				arg_403_1.text_.text = var_406_31

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_33 = 15 <= 0 and var_406_28 or var_406_28 * (utf8.len(var_406_31) / 15)

				if (15 <= 0 and var_406_28 or var_406_28 * (utf8.len(var_406_31) / 15)) > 0 and var_406_28 < var_406_33 then
					arg_403_1.talkMaxDuration = var_406_33
					var_406_27 = var_406_27 + 0.3

					if var_406_33 + var_406_27 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_33 + var_406_27
					end
				end

				arg_403_1.text_.text = var_406_31
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151096", "story_v_out_322151.awb") ~= 0 then
					local var_406_34 = manager.audio:GetVoiceLength("story_v_out_322151", "322151096", "story_v_out_322151.awb") / 1000

					if var_406_34 + var_406_27 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_34 + var_406_27
					end

					if var_406_30.prefab_name ~= "" and arg_403_1.actors_[var_406_30.prefab_name] ~= nil then
						local var_406_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_30.prefab_name].transform, "story_v_out_322151", "322151096", "story_v_out_322151.awb")

						arg_403_1:RecordAudio("322151096", var_406_35)
						arg_403_1:RecordAudio("322151096", var_406_35)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_322151", "322151096", "story_v_out_322151.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_322151", "322151096", "story_v_out_322151.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_36 = var_406_27 + 0.3
			local var_406_37 = math.max(var_406_28, arg_403_1.talkMaxDuration)

			if var_406_27 + 0.3 <= arg_403_1.time_ and arg_403_1.time_ < var_406_36 + var_406_37 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_36) / var_406_37

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_36 + var_406_37 and arg_403_1.time_ < var_406_36 + var_406_37 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play322151097 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 322151097
		arg_409_1.duration_ = 5

		local var_409_0 = {
			zh = 3.8,
			ja = 5
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play322151098(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1029ui_story = arg_409_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1029ui_story"].transform.position).z)
				arg_409_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1029ui_story"].transform.localEulerAngles = arg_409_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, -1.09, -6.2)
				arg_409_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["1029ui_story"].transform.position).z)
				arg_409_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["1029ui_story"].transform.localEulerAngles = arg_409_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_412_1 = 0
			local var_412_2 = 0.475

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_3 = arg_409_1:GetWordFromCfg(322151097)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_6 = 19 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 19)

				if (19 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 19)) > 0 and var_412_2 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151097", "story_v_out_322151.awb") ~= 0 then
					local var_412_7 = manager.audio:GetVoiceLength("story_v_out_322151", "322151097", "story_v_out_322151.awb") / 1000

					if var_412_7 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_1
					end

					if var_412_3.prefab_name ~= "" and arg_409_1.actors_[var_412_3.prefab_name] ~= nil then
						local var_412_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_3.prefab_name].transform, "story_v_out_322151", "322151097", "story_v_out_322151.awb")

						arg_409_1:RecordAudio("322151097", var_412_8)
						arg_409_1:RecordAudio("322151097", var_412_8)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_322151", "322151097", "story_v_out_322151.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_322151", "322151097", "story_v_out_322151.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_9 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_9 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_9

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_9 and arg_409_1.time_ < var_412_1 + var_412_9 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play322151098 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 322151098
		arg_413_1.duration_ = 7.2

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play322151099(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 2.00000000298023 < arg_413_1.time_ and arg_413_1.time_ <= 2.00000000298023 + arg_416_0 then
				local var_416_0 = arg_413_1.bgs_.MS2209

				arg_413_1.bgs_.MS2209.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_416_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_416_1 = var_416_0:GetComponent("SpriteRenderer")

				if var_416_1 and var_416_1.sprite then
					local var_416_2 = 2 * (var_416_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_416_0.transform.localScale = Vector3.New(var_416_2 / var_416_1.sprite.bounds.size.y < var_416_2 * manager.ui.mainCameraCom_.aspect / var_416_1.sprite.bounds.size.x and var_416_2 * manager.ui.mainCameraCom_.aspect / var_416_1.sprite.bounds.size.x or var_416_2 / var_416_1.sprite.bounds.size.y, var_416_2 / var_416_1.sprite.bounds.size.y < var_416_2 * manager.ui.mainCameraCom_.aspect / var_416_1.sprite.bounds.size.x and var_416_2 * manager.ui.mainCameraCom_.aspect / var_416_1.sprite.bounds.size.x or var_416_2 / var_416_1.sprite.bounds.size.y, 0)
				end

				for iter_416_0, iter_416_1 in pairs(arg_413_1.bgs_) do
					if iter_416_0 ~= "MS2209" then
						iter_416_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_416_3 = 4.00000000298023

			if 4.00000000298023 < arg_413_1.time_ and arg_413_1.time_ <= var_416_3 + arg_416_0 then
				arg_413_1.allBtn_.enabled = false
			end

			if arg_413_1.time_ >= var_416_3 + 0.3 and arg_413_1.time_ < var_416_3 + 0.3 + arg_416_0 then
				arg_413_1.allBtn_.enabled = true
			end

			local var_416_4 = 0

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_5 = 2

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_5 then
				local var_416_6 = Color.New(0, 0, 0)

				var_416_6.a = Mathf.Lerp(0, 1, (arg_413_1.time_ - var_416_4) / var_416_5)
				arg_413_1.mask_.color = var_416_6
			end

			if arg_413_1.time_ >= var_416_4 + var_416_5 and arg_413_1.time_ < var_416_4 + var_416_5 + arg_416_0 then
				local var_416_7 = Color.New(0, 0, 0)

				var_416_7.a = 1
				arg_413_1.mask_.color = var_416_7
			end

			local var_416_8 = 2.00000000298023

			if 2.00000000298023 < arg_413_1.time_ and arg_413_1.time_ <= var_416_8 + arg_416_0 then
				arg_413_1.mask_.enabled = true
				arg_413_1.mask_.raycastTarget = true

				arg_413_1:SetGaussion(false)
			end

			local var_416_9 = 2

			if var_416_8 <= arg_413_1.time_ and arg_413_1.time_ < var_416_8 + var_416_9 then
				local var_416_10 = Color.New(0, 0, 0)

				var_416_10.a = Mathf.Lerp(1, 0, (arg_413_1.time_ - var_416_8) / var_416_9)
				arg_413_1.mask_.color = var_416_10
			end

			if arg_413_1.time_ >= var_416_8 + var_416_9 and arg_413_1.time_ < var_416_8 + var_416_9 + arg_416_0 then
				local var_416_11 = Color.New(0, 0, 0)

				arg_413_1.mask_.enabled = false
				var_416_11.a = 0
				arg_413_1.mask_.color = var_416_11
			end

			local var_416_12 = arg_413_1.actors_["1029ui_story"].transform

			if 1.96599999815226 < arg_413_1.time_ and arg_413_1.time_ <= 1.96599999815226 + arg_416_0 then
				arg_413_1.var_.moveOldPos1029ui_story = var_416_12.localPosition
			end

			local var_416_13 = 0.001

			if 1.96599999815226 <= arg_413_1.time_ and arg_413_1.time_ < 1.96599999815226 + var_416_13 then
				var_416_12.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_413_1.time_ - 1.96599999815226) / var_416_13)
				var_416_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_12.position).x, (manager.ui.mainCamera.transform.position - var_416_12.position).y, (manager.ui.mainCamera.transform.position - var_416_12.position).z)
				var_416_12.localEulerAngles.z = 0
				var_416_12.localEulerAngles.x = 0
				var_416_12.localEulerAngles = var_416_12.localEulerAngles
			end

			if arg_413_1.time_ >= 1.96599999815226 + var_416_13 and arg_413_1.time_ < 1.96599999815226 + var_416_13 + arg_416_0 then
				var_416_12.localPosition = Vector3.New(0, 100, 0)
				var_416_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_12.position).x, (manager.ui.mainCamera.transform.position - var_416_12.position).y, (manager.ui.mainCamera.transform.position - var_416_12.position).z)
				var_416_12.localEulerAngles.z = 0
				var_416_12.localEulerAngles.x = 0
				var_416_12.localEulerAngles = var_416_12.localEulerAngles
			end

			local var_416_14 = arg_413_1.actors_["1029ui_story"]

			if 1.98333333333333 < arg_413_1.time_ and arg_413_1.time_ <= 1.98333333333333 + arg_416_0 and not isNil(var_416_14) and arg_413_1.var_.characterEffect1029ui_story == nil then
				arg_413_1.var_.characterEffect1029ui_story = var_416_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_15 = 0.0166666666666666

			if 1.98333333333333 <= arg_413_1.time_ and arg_413_1.time_ < 1.98333333333333 + var_416_15 and not isNil(var_416_14) then
				if arg_413_1.var_.characterEffect1029ui_story and not isNil(var_416_14) then
					arg_413_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 1.98333333333333) / var_416_15)
				end
			end

			if arg_413_1.time_ >= 1.98333333333333 + var_416_15 and arg_413_1.time_ < 1.98333333333333 + var_416_15 + arg_416_0 and not isNil(var_416_14) and arg_413_1.var_.characterEffect1029ui_story then
				arg_413_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_416_16 = 1.9

			arg_413_1.isInRecall_ = false

			if var_416_16 < arg_413_1.time_ and arg_413_1.time_ <= var_416_16 + arg_416_0 then
				arg_413_1.screenFilterGo_:SetActive(false)

				for iter_416_2, iter_416_3 in pairs(arg_413_1.actors_) do
					for iter_416_4, iter_416_5 in ipairs((iter_416_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_416_5.color = iter_416_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_416_17 = 0.1

			if var_416_16 <= arg_413_1.time_ and arg_413_1.time_ < var_416_16 + var_416_17 then
				arg_413_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_413_1.time_ - var_416_16) / var_416_17)
			end

			if arg_413_1.time_ >= var_416_16 + var_416_17 and arg_413_1.time_ < var_416_16 + var_416_17 + arg_416_0 then
				arg_413_1.screenFilterEffect_.weight = 0
			end

			local var_416_18 = 2

			arg_413_1.isInRecall_ = false

			if var_416_18 < arg_413_1.time_ and arg_413_1.time_ <= var_416_18 + arg_416_0 then
				arg_413_1.screenFilterGo_:SetActive(false)

				for iter_416_6, iter_416_7 in pairs(arg_413_1.actors_) do
					for iter_416_8, iter_416_9 in ipairs((iter_416_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_416_9.color = iter_416_9.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_416_19 = 0.034000001847744

			if var_416_18 <= arg_413_1.time_ and arg_413_1.time_ < var_416_18 + var_416_19 then
				arg_413_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_413_1.time_ - var_416_18) / var_416_19)
			end

			if arg_413_1.time_ >= var_416_18 + var_416_19 and arg_413_1.time_ < var_416_18 + var_416_19 + arg_416_0 then
				arg_413_1.screenFilterEffect_.weight = 0
			end

			if 0.2 < arg_413_1.time_ and arg_413_1.time_ <= 0.2 + arg_416_0 then
				arg_413_1:AudioAction("stop", "effect", "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if 1.56666666666667 < arg_413_1.time_ and arg_413_1.time_ <= 1.56666666666667 + arg_416_0 then
				arg_413_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			local var_416_22 = arg_413_1.bgs_.MS2209.transform

			if 2.00000000298023 < arg_413_1.time_ and arg_413_1.time_ <= 2.00000000298023 + arg_416_0 then
				arg_413_1.var_.moveOldPosMS2209 = var_416_22.localPosition
			end

			local var_416_23 = 1.73333333333333

			if 2.00000000298023 <= arg_413_1.time_ and arg_413_1.time_ < 2.00000000298023 + var_416_23 then
				var_416_22.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPosMS2209, Vector3.New(0, 1.2, 9), (arg_413_1.time_ - 2.00000000298023) / var_416_23)
			end

			if arg_413_1.time_ >= 2.00000000298023 + var_416_23 and arg_413_1.time_ < 2.00000000298023 + var_416_23 + arg_416_0 then
				var_416_22.localPosition = Vector3.New(0, 1.2, 9)
			end

			if arg_413_1.frameCnt_ <= 1 then
				arg_413_1.dialog_:SetActive(false)
			end

			local var_416_24 = 3.8
			local var_416_25 = 0.05

			if 3.8 < arg_413_1.time_ and arg_413_1.time_ <= var_416_24 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0

				arg_413_1.dialog_:SetActive(true)

				arg_413_1.dialogCg_.alpha = 0

				local var_416_26 = LeanTween.value(arg_413_1.dialog_, 0, 1, 0.3)

				var_416_26:setOnUpdate(LuaHelper.FloatAction(function(arg_417_0)
					arg_413_1.dialogCg_.alpha = arg_417_0
				end))
				var_416_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_413_1.dialog_)
					var_416_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_413_1.duration_ = arg_413_1.duration_ + 0.3

				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_27 = arg_413_1:GetWordFromCfg(322151098)
				local var_416_28 = arg_413_1:FormatText(var_416_27.content)

				arg_413_1.text_.text = var_416_28

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_30 = 2 <= 0 and var_416_25 or var_416_25 * (utf8.len(var_416_28) / 2)

				if (2 <= 0 and var_416_25 or var_416_25 * (utf8.len(var_416_28) / 2)) > 0 and var_416_25 < var_416_30 then
					arg_413_1.talkMaxDuration = var_416_30
					var_416_24 = var_416_24 + 0.3

					if var_416_30 + var_416_24 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_30 + var_416_24
					end
				end

				arg_413_1.text_.text = var_416_28
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151098", "story_v_out_322151.awb") ~= 0 then
					local var_416_31 = manager.audio:GetVoiceLength("story_v_out_322151", "322151098", "story_v_out_322151.awb") / 1000

					if var_416_31 + var_416_24 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_31 + var_416_24
					end

					if var_416_27.prefab_name ~= "" and arg_413_1.actors_[var_416_27.prefab_name] ~= nil then
						local var_416_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_27.prefab_name].transform, "story_v_out_322151", "322151098", "story_v_out_322151.awb")

						arg_413_1:RecordAudio("322151098", var_416_32)
						arg_413_1:RecordAudio("322151098", var_416_32)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_322151", "322151098", "story_v_out_322151.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_322151", "322151098", "story_v_out_322151.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_33 = var_416_24 + 0.3
			local var_416_34 = math.max(var_416_25, arg_413_1.talkMaxDuration)

			if var_416_24 + 0.3 <= arg_413_1.time_ and arg_413_1.time_ < var_416_33 + var_416_34 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_33) / var_416_34

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_33 + var_416_34 and arg_413_1.time_ < var_416_33 + var_416_34 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.73333333333333,
				startTime = 2.00000000298023,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1.2, 9),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play322151099 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 322151099
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play322151100(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 1.275

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(322151099).content)

				arg_419_1.text_.text = var_422_1

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_3 = 51 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 51)

				if (51 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_1) / 51)) > 0 and var_422_0 < var_422_3 then
					arg_419_1.talkMaxDuration = var_422_3

					if var_422_3 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_3 + 0
					end
				end

				arg_419_1.text_.text = var_422_1
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_4 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_4

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play322151100 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 322151100
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play322151101(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 1.1

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_1 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(322151100).content)

				arg_423_1.text_.text = var_426_1

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_3 = 44 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 44)

				if (44 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 44)) > 0 and var_426_0 < var_426_3 then
					arg_423_1.talkMaxDuration = var_426_3

					if var_426_3 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_3 + 0
					end
				end

				arg_423_1.text_.text = var_426_1
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_4 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_4 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_4

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_4 and arg_423_1.time_ < 0 + var_426_4 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play322151101 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 322151101
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play322151102(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0.925

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_1 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(322151101).content)

				arg_427_1.text_.text = var_430_1

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_3 = 37 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 37)

				if (37 <= 0 and var_430_0 or var_430_0 * (utf8.len(var_430_1) / 37)) > 0 and var_430_0 < var_430_3 then
					arg_427_1.talkMaxDuration = var_430_3

					if var_430_3 + 0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_3 + 0
					end
				end

				arg_427_1.text_.text = var_430_1
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_4 = math.max(var_430_0, arg_427_1.talkMaxDuration)

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - 0) / var_430_4

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play322151102 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 322151102
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play322151103(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 1.075

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_1 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(322151102).content)

				arg_431_1.text_.text = var_434_1

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_3 = 43 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 43)

				if (43 <= 0 and var_434_0 or var_434_0 * (utf8.len(var_434_1) / 43)) > 0 and var_434_0 < var_434_3 then
					arg_431_1.talkMaxDuration = var_434_3

					if var_434_3 + 0 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_3 + 0
					end
				end

				arg_431_1.text_.text = var_434_1
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_4 = math.max(var_434_0, arg_431_1.talkMaxDuration)

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_4 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - 0) / var_434_4

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= 0 + var_434_4 and arg_431_1.time_ < 0 + var_434_4 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play322151103 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 322151103
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play322151104(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0.775

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_1 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(322151103).content)

				arg_435_1.text_.text = var_438_1

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_3 = 31 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 31)

				if (31 <= 0 and var_438_0 or var_438_0 * (utf8.len(var_438_1) / 31)) > 0 and var_438_0 < var_438_3 then
					arg_435_1.talkMaxDuration = var_438_3

					if var_438_3 + 0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_3 + 0
					end
				end

				arg_435_1.text_.text = var_438_1
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_4 = math.max(var_438_0, arg_435_1.talkMaxDuration)

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_4 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - 0) / var_438_4

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= 0 + var_438_4 and arg_435_1.time_ < 0 + var_438_4 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play322151104 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 322151104
		arg_439_1.duration_ = 5.77

		local var_439_0 = {
			zh = 3.166,
			ja = 5.766
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play322151105(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0.325

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_1 = arg_439_1:GetWordFromCfg(322151104)
				local var_442_2 = arg_439_1:FormatText(var_442_1.content)

				arg_439_1.text_.text = var_442_2

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_4 = 13 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 13)

				if (13 <= 0 and var_442_0 or var_442_0 * (utf8.len(var_442_2) / 13)) > 0 and var_442_0 < var_442_4 then
					arg_439_1.talkMaxDuration = var_442_4

					if var_442_4 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_4 + 0
					end
				end

				arg_439_1.text_.text = var_442_2
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151104", "story_v_out_322151.awb") ~= 0 then
					local var_442_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151104", "story_v_out_322151.awb") / 1000

					if var_442_5 + 0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + 0
					end

					if var_442_1.prefab_name ~= "" and arg_439_1.actors_[var_442_1.prefab_name] ~= nil then
						local var_442_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_1.prefab_name].transform, "story_v_out_322151", "322151104", "story_v_out_322151.awb")

						arg_439_1:RecordAudio("322151104", var_442_6)
						arg_439_1:RecordAudio("322151104", var_442_6)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_322151", "322151104", "story_v_out_322151.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_322151", "322151104", "story_v_out_322151.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_7 = math.max(var_442_0, arg_439_1.talkMaxDuration)

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_7 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - 0) / var_442_7

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= 0 + var_442_7 and arg_439_1.time_ < 0 + var_442_7 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play322151105 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 322151105
		arg_443_1.duration_ = 5

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play322151106(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0.55

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_1 = arg_443_1:FormatText(arg_443_1:GetWordFromCfg(322151105).content)

				arg_443_1.text_.text = var_446_1

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_3 = 22 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 22)

				if (22 <= 0 and var_446_0 or var_446_0 * (utf8.len(var_446_1) / 22)) > 0 and var_446_0 < var_446_3 then
					arg_443_1.talkMaxDuration = var_446_3

					if var_446_3 + 0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_3 + 0
					end
				end

				arg_443_1.text_.text = var_446_1
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)
				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_4 = math.max(var_446_0, arg_443_1.talkMaxDuration)

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_4 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - 0) / var_446_4

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= 0 + var_446_4 and arg_443_1.time_ < 0 + var_446_4 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play322151106 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 322151106
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play322151107(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0.9

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, false)
				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_1 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(322151106).content)

				arg_447_1.text_.text = var_450_1

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_3 = 36 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 36)

				if (36 <= 0 and var_450_0 or var_450_0 * (utf8.len(var_450_1) / 36)) > 0 and var_450_0 < var_450_3 then
					arg_447_1.talkMaxDuration = var_450_3

					if var_450_3 + 0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_3 + 0
					end
				end

				arg_447_1.text_.text = var_450_1
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_4 = math.max(var_450_0, arg_447_1.talkMaxDuration)

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_4 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - 0) / var_450_4

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= 0 + var_450_4 and arg_447_1.time_ < 0 + var_450_4 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play322151107 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 322151107
		arg_451_1.duration_ = 5

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play322151108(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = 1.025

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_1 = arg_451_1:FormatText(arg_451_1:GetWordFromCfg(322151107).content)

				arg_451_1.text_.text = var_454_1

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_3 = 41 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 41)

				if (41 <= 0 and var_454_0 or var_454_0 * (utf8.len(var_454_1) / 41)) > 0 and var_454_0 < var_454_3 then
					arg_451_1.talkMaxDuration = var_454_3

					if var_454_3 + 0 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_3 + 0
					end
				end

				arg_451_1.text_.text = var_454_1
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)
				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_4 = math.max(var_454_0, arg_451_1.talkMaxDuration)

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_4 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - 0) / var_454_4

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= 0 + var_454_4 and arg_451_1.time_ < 0 + var_454_4 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {}

		arg_451_1:InitPlayNodeList()
	end,
	Play322151108 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 322151108
		arg_455_1.duration_ = 7.93

		local var_455_0 = {
			zh = 6.86666666666667,
			ja = 7.93266666666667
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play322151109(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPosMS2209 = arg_455_1.bgs_.MS2209.transform.localPosition
			end

			local var_458_0 = 0.7

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 then
				arg_455_1.bgs_.MS2209.transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPosMS2209, Vector3.New(0.2, 1.2, 9), (arg_455_1.time_ - 0) / var_458_0)
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 then
				arg_455_1.bgs_.MS2209.transform.localPosition = Vector3.New(0.2, 1.2, 9)
			end

			local var_458_1 = 0

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.allBtn_.enabled = false
			end

			if arg_455_1.time_ >= var_458_1 + 1 and arg_455_1.time_ < var_458_1 + 1 + arg_458_0 then
				arg_455_1.allBtn_.enabled = true
			end

			if arg_455_1.frameCnt_ <= 1 then
				arg_455_1.dialog_:SetActive(false)
			end

			local var_458_2 = 0.366666666666667
			local var_458_3 = 0.775

			if 0.366666666666667 < arg_455_1.time_ and arg_455_1.time_ <= var_458_2 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0

				arg_455_1.dialog_:SetActive(true)

				arg_455_1.dialogCg_.alpha = 0

				local var_458_4 = LeanTween.value(arg_455_1.dialog_, 0, 1, 0.3)

				var_458_4:setOnUpdate(LuaHelper.FloatAction(function(arg_459_0)
					arg_455_1.dialogCg_.alpha = arg_459_0
				end))
				var_458_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_455_1.dialog_)
					var_458_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_455_1.duration_ = arg_455_1.duration_ + 0.3

				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_5 = arg_455_1:GetWordFromCfg(322151108)
				local var_458_6 = arg_455_1:FormatText(var_458_5.content)

				arg_455_1.text_.text = var_458_6

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_8 = 31 <= 0 and var_458_3 or var_458_3 * (utf8.len(var_458_6) / 31)

				if (31 <= 0 and var_458_3 or var_458_3 * (utf8.len(var_458_6) / 31)) > 0 and var_458_3 < var_458_8 then
					arg_455_1.talkMaxDuration = var_458_8
					var_458_2 = var_458_2 + 0.3

					if var_458_8 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_8 + var_458_2
					end
				end

				arg_455_1.text_.text = var_458_6
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151108", "story_v_out_322151.awb") ~= 0 then
					local var_458_9 = manager.audio:GetVoiceLength("story_v_out_322151", "322151108", "story_v_out_322151.awb") / 1000

					if var_458_9 + var_458_2 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_9 + var_458_2
					end

					if var_458_5.prefab_name ~= "" and arg_455_1.actors_[var_458_5.prefab_name] ~= nil then
						local var_458_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_5.prefab_name].transform, "story_v_out_322151", "322151108", "story_v_out_322151.awb")

						arg_455_1:RecordAudio("322151108", var_458_10)
						arg_455_1:RecordAudio("322151108", var_458_10)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_322151", "322151108", "story_v_out_322151.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_322151", "322151108", "story_v_out_322151.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_11 = var_458_2 + 0.3
			local var_458_12 = math.max(var_458_3, arg_455_1.talkMaxDuration)

			if var_458_2 + 0.3 <= arg_455_1.time_ and arg_455_1.time_ < var_458_11 + var_458_12 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_11) / var_458_12

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_11 + var_458_12 and arg_455_1.time_ < var_458_11 + var_458_12 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.7,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.2, 9),
					endPos = Vector3.New(0.2, 1.2, 9),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play322151109 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 322151109
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play322151110(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0.325

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_1 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(322151109).content)

				arg_461_1.text_.text = var_464_1

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_3 = 13 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 13)

				if (13 <= 0 and var_464_0 or var_464_0 * (utf8.len(var_464_1) / 13)) > 0 and var_464_0 < var_464_3 then
					arg_461_1.talkMaxDuration = var_464_3

					if var_464_3 + 0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_3 + 0
					end
				end

				arg_461_1.text_.text = var_464_1
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_4 = math.max(var_464_0, arg_461_1.talkMaxDuration)

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - 0) / var_464_4

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play322151110 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 322151110
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play322151111(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 1.125

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(322151110).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 45 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 45)

				if (45 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 45)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play322151111 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 322151111
		arg_469_1.duration_ = 4.23

		local var_469_0 = {
			zh = 3.3,
			ja = 4.233
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play322151112(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.275

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:GetWordFromCfg(322151111)
				local var_472_2 = arg_469_1:FormatText(var_472_1.content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 11 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 11)

				if (11 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 11)) > 0 and var_472_0 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + 0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151111", "story_v_out_322151.awb") ~= 0 then
					local var_472_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151111", "story_v_out_322151.awb") / 1000

					if var_472_5 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + 0
					end

					if var_472_1.prefab_name ~= "" and arg_469_1.actors_[var_472_1.prefab_name] ~= nil then
						local var_472_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_1.prefab_name].transform, "story_v_out_322151", "322151111", "story_v_out_322151.awb")

						arg_469_1:RecordAudio("322151111", var_472_6)
						arg_469_1:RecordAudio("322151111", var_472_6)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_322151", "322151111", "story_v_out_322151.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_322151", "322151111", "story_v_out_322151.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play322151112 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 322151112
		arg_473_1.duration_ = 10.43

		local var_473_0 = {
			zh = 6,
			ja = 10.433
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play322151113(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.7

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:GetWordFromCfg(322151112)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 28 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 28)

				if (28 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 28)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151112", "story_v_out_322151.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151112", "story_v_out_322151.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_out_322151", "322151112", "story_v_out_322151.awb")

						arg_473_1:RecordAudio("322151112", var_476_6)
						arg_473_1:RecordAudio("322151112", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_322151", "322151112", "story_v_out_322151.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_322151", "322151112", "story_v_out_322151.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play322151113 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 322151113
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play322151114(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.45

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_1 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(322151113).content)

				arg_477_1.text_.text = var_480_1

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_3 = 18 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 18)

				if (18 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_1) / 18)) > 0 and var_480_0 < var_480_3 then
					arg_477_1.talkMaxDuration = var_480_3

					if var_480_3 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_3 + 0
					end
				end

				arg_477_1.text_.text = var_480_1
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_4 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_4

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play322151114 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 322151114
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play322151115(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 1.825

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(322151114).content)

				arg_481_1.text_.text = var_484_1

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_3 = 73 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 73)

				if (73 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 73)) > 0 and var_484_0 < var_484_3 then
					arg_481_1.talkMaxDuration = var_484_3

					if var_484_3 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_3 + 0
					end
				end

				arg_481_1.text_.text = var_484_1
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_4 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_4

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play322151115 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 322151115
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play322151116(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0.625

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_1 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(322151115).content)

				arg_485_1.text_.text = var_488_1

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_3 = 25 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 25)

				if (25 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_1) / 25)) > 0 and var_488_0 < var_488_3 then
					arg_485_1.talkMaxDuration = var_488_3

					if var_488_3 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_3 + 0
					end
				end

				arg_485_1.text_.text = var_488_1
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_4 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_4

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play322151116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 322151116
		arg_489_1.duration_ = 9

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play322151117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_9000

			if arg_489_1.bgs_.MS2209a == nil then
				local var_492_0 = Object.Instantiate(arg_489_1.paintGo_)

				var_492_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2209a")
				var_492_0.name = "MS2209a"
				var_492_0.transform.parent = arg_489_1.stage_.transform
				var_492_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.bgs_.MS2209a = var_492_0
			end

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= 2 + arg_492_0 then
				local var_492_1 = arg_489_1.bgs_.MS2209a

				arg_489_1.bgs_.MS2209a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_492_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_492_2 = var_492_1:GetComponent("SpriteRenderer")

				if var_492_2 and var_492_2.sprite then
					local var_492_3 = 2 * (var_492_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_492_1.transform.localScale = Vector3.New(var_492_3 / var_492_2.sprite.bounds.size.y < var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x and var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x or var_492_3 / var_492_2.sprite.bounds.size.y, var_492_3 / var_492_2.sprite.bounds.size.y < var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x and var_492_3 * manager.ui.mainCameraCom_.aspect / var_492_2.sprite.bounds.size.x or var_492_3 / var_492_2.sprite.bounds.size.y, 0)
				end

				for iter_492_0, iter_492_1 in pairs(arg_489_1.bgs_) do
					if iter_492_0 ~= "MS2209a" then
						iter_492_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_492_4 = 4

			if 4 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1.allBtn_.enabled = false
			end

			if arg_489_1.time_ >= var_492_4 + 1.53333333333333 and arg_489_1.time_ < var_492_4 + 1.53333333333333 + arg_492_0 then
				arg_489_1.allBtn_.enabled = true
			end

			local var_492_5 = 0

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_5 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_6 = 2

			if var_492_5 <= arg_489_1.time_ and arg_489_1.time_ < var_492_5 + var_492_6 then
				local var_492_7 = Color.New(0, 0, 0)

				var_492_7.a = Mathf.Lerp(0, 1, (arg_489_1.time_ - var_492_5) / var_492_6)
				arg_489_1.mask_.color = var_492_7
			end

			if arg_489_1.time_ >= var_492_5 + var_492_6 and arg_489_1.time_ < var_492_5 + var_492_6 + arg_492_0 then
				local var_492_8 = Color.New(0, 0, 0)

				var_492_8.a = 1
				arg_489_1.mask_.color = var_492_8
			end

			local var_492_9 = 2

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= var_492_9 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_10 = 2

			if var_492_9 <= arg_489_1.time_ and arg_489_1.time_ < var_492_9 + var_492_10 then
				local var_492_11 = Color.New(0, 0, 0)

				var_492_11.a = Mathf.Lerp(1, 0, (arg_489_1.time_ - var_492_9) / var_492_10)
				arg_489_1.mask_.color = var_492_11
			end

			if arg_489_1.time_ >= var_492_9 + var_492_10 and arg_489_1.time_ < var_492_9 + var_492_10 + arg_492_0 then
				local var_492_12 = Color.New(0, 0, 0)

				arg_489_1.mask_.enabled = false
				var_492_12.a = 0
				arg_489_1.mask_.color = var_492_12
			end

			if 0.3 < arg_489_1.time_ and arg_489_1.time_ <= 0.3 + arg_492_0 then
				arg_489_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 1.56666666666667 < arg_489_1.time_ and arg_489_1.time_ <= 1.56666666666667 + arg_492_0 then
				arg_489_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_gold_rain", "")
			end

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= 2 + arg_492_0 then
				local var_492_15 = arg_489_1.var_.effect1116

				if not arg_489_1.var_.effect1116 then
					var_492_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), manager.ui.mainCamera.transform)
					var_492_15.name = "1116"
					arg_489_1.var_.effect1116 = var_492_15
				else
					var_492_15.transform:SetParent(var_492_9000)
				end

				var_492_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_492_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_492_17 = arg_489_1.bgs_.MS2209a.transform

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= 2 + arg_492_0 then
				arg_489_1.var_.moveOldPosMS2209a = var_492_17.localPosition
			end

			local var_492_18 = 1.73333333333333

			if 2 <= arg_489_1.time_ and arg_489_1.time_ < 2 + var_492_18 then
				var_492_17.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPosMS2209a, Vector3.New(0, 0.8, 8.5), (arg_489_1.time_ - 2) / var_492_18)
			end

			if arg_489_1.time_ >= 2 + var_492_18 and arg_489_1.time_ < 2 + var_492_18 + arg_492_0 then
				var_492_17.localPosition = Vector3.New(0, 0.8, 8.5)
			end

			if arg_489_1.frameCnt_ <= 1 then
				arg_489_1.dialog_:SetActive(false)
			end

			local var_492_19 = 4
			local var_492_20 = 1.625

			if 4 < arg_489_1.time_ and arg_489_1.time_ <= var_492_19 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0

				arg_489_1.dialog_:SetActive(true)

				arg_489_1.dialogCg_.alpha = 0

				local var_492_21 = LeanTween.value(arg_489_1.dialog_, 0, 1, 0.3)

				var_492_21:setOnUpdate(LuaHelper.FloatAction(function(arg_493_0)
					arg_489_1.dialogCg_.alpha = arg_493_0
				end))
				var_492_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_489_1.dialog_)
					var_492_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_489_1.duration_ = arg_489_1.duration_ + 0.3

				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_22 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(322151116).content)

				arg_489_1.text_.text = var_492_22

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_24 = 65 <= 0 and var_492_20 or var_492_20 * (utf8.len(var_492_22) / 65)

				if (65 <= 0 and var_492_20 or var_492_20 * (utf8.len(var_492_22) / 65)) > 0 and var_492_20 < var_492_24 then
					arg_489_1.talkMaxDuration = var_492_24
					var_492_19 = var_492_19 + 0.3

					if var_492_24 + var_492_19 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_24 + var_492_19
					end
				end

				arg_489_1.text_.text = var_492_22
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_25 = var_492_19 + 0.3
			local var_492_26 = math.max(var_492_20, arg_489_1.talkMaxDuration)

			if var_492_19 + 0.3 <= arg_489_1.time_ and arg_489_1.time_ < var_492_25 + var_492_26 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_25) / var_492_26

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_25 + var_492_26 and arg_489_1.time_ < var_492_25 + var_492_26 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.73333333333333,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 8),
					endPos = Vector3.New(0, 0.8, 8.5),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play322151117 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 322151117
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play322151118(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.125

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_1 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(322151117).content)

				arg_495_1.text_.text = var_498_1

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_3 = 5 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 5)

				if (5 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 5)) > 0 and var_498_0 < var_498_3 then
					arg_495_1.talkMaxDuration = var_498_3

					if var_498_3 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_3 + 0
					end
				end

				arg_495_1.text_.text = var_498_1
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_4 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_4 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_4

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_4 and arg_495_1.time_ < 0 + var_498_4 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play322151118 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 322151118
		arg_499_1.duration_ = 5

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play322151119(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 1.075

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, false)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_1 = arg_499_1:FormatText(arg_499_1:GetWordFromCfg(322151118).content)

				arg_499_1.text_.text = var_502_1

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_3 = 43 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_1) / 43)

				if (43 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_1) / 43)) > 0 and var_502_0 < var_502_3 then
					arg_499_1.talkMaxDuration = var_502_3

					if var_502_3 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_3 + 0
					end
				end

				arg_499_1.text_.text = var_502_1
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)
				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_4 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_4 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_4

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_4 and arg_499_1.time_ < 0 + var_502_4 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play322151119 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 322151119
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play322151120(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 1.15

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, false)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(322151119).content)

				arg_503_1.text_.text = var_506_1

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_3 = 46 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 46)

				if (46 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_1) / 46)) > 0 and var_506_0 < var_506_3 then
					arg_503_1.talkMaxDuration = var_506_3

					if var_506_3 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_3 + 0
					end
				end

				arg_503_1.text_.text = var_506_1
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_4 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_4 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_4

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_4 and arg_503_1.time_ < 0 + var_506_4 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play322151120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 322151120
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play322151121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0.333333333333333 < arg_507_1.time_ and arg_507_1.time_ <= 0.333333333333333 + arg_510_0 then
				arg_507_1:AudioAction("play", "effect", "se_story_145", "se_story_145_caoza", "")
			end

			local var_510_1 = 0
			local var_510_2 = 1.675

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_3 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(322151120).content)

				arg_507_1.text_.text = var_510_3

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_5 = 67 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 67)

				if (67 <= 0 and var_510_2 or var_510_2 * (utf8.len(var_510_3) / 67)) > 0 and var_510_2 < var_510_5 then
					arg_507_1.talkMaxDuration = var_510_5

					if var_510_5 + var_510_1 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + var_510_1
					end
				end

				arg_507_1.text_.text = var_510_3
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_6 = math.max(var_510_2, arg_507_1.talkMaxDuration)

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_6 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_1) / var_510_6

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_1 + var_510_6 and arg_507_1.time_ < var_510_1 + var_510_6 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play322151121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 322151121
		arg_511_1.duration_ = 5.18

		local var_511_0 = {
			zh = 4.21633333333333,
			ja = 5.18333333333333
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play322151122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0.166666666666667 < arg_511_1.time_ and arg_511_1.time_ <= 0.166666666666667 + arg_514_0 then
				local var_514_0 = arg_511_1.var_.effect1116

				if not arg_511_1.var_.effect1116 then
					var_514_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), manager.ui.mainCamera.transform)
					var_514_0.name = "1116"
					arg_511_1.var_.effect1116 = var_514_0
				else
					var_514_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_514_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_514_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_514_2 = 0

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_2 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = true

				arg_511_1:SetGaussion(false)
			end

			local var_514_3 = 0.183333333333333

			if var_514_2 <= arg_511_1.time_ and arg_511_1.time_ < var_514_2 + var_514_3 then
				local var_514_4 = Color.New(0, 0, 0)

				var_514_4.a = Mathf.Lerp(0, 1, (arg_511_1.time_ - var_514_2) / var_514_3)
				arg_511_1.mask_.color = var_514_4
			end

			if arg_511_1.time_ >= var_514_2 + var_514_3 and arg_511_1.time_ < var_514_2 + var_514_3 + arg_514_0 then
				local var_514_5 = Color.New(0, 0, 0)

				var_514_5.a = 1
				arg_511_1.mask_.color = var_514_5
			end

			local var_514_6 = 0.183333333333333

			if 0.183333333333333 < arg_511_1.time_ and arg_511_1.time_ <= var_514_6 + arg_514_0 then
				arg_511_1.mask_.enabled = true
				arg_511_1.mask_.raycastTarget = true

				arg_511_1:SetGaussion(false)
			end

			local var_514_7 = 0.183333333333333

			if var_514_6 <= arg_511_1.time_ and arg_511_1.time_ < var_514_6 + var_514_7 then
				local var_514_8 = Color.New(0, 0, 0)

				var_514_8.a = Mathf.Lerp(1, 0, (arg_511_1.time_ - var_514_6) / var_514_7)
				arg_511_1.mask_.color = var_514_8
			end

			if arg_511_1.time_ >= var_514_6 + var_514_7 and arg_511_1.time_ < var_514_6 + var_514_7 + arg_514_0 then
				local var_514_9 = Color.New(0, 0, 0)

				arg_511_1.mask_.enabled = false
				var_514_9.a = 0
				arg_511_1.mask_.color = var_514_9
			end

			if arg_511_1.frameCnt_ <= 1 then
				arg_511_1.dialog_:SetActive(false)
			end

			local var_514_10 = 0.183333333333333
			local var_514_11 = 0.475

			if 0.183333333333333 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0

				arg_511_1.dialog_:SetActive(true)

				arg_511_1.dialogCg_.alpha = 0

				local var_514_12 = LeanTween.value(arg_511_1.dialog_, 0, 1, 0.3)

				var_514_12:setOnUpdate(LuaHelper.FloatAction(function(arg_515_0)
					arg_511_1.dialogCg_.alpha = arg_515_0
				end))
				var_514_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_511_1.dialog_)
					var_514_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_511_1.duration_ = arg_511_1.duration_ + 0.3

				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_13 = arg_511_1:GetWordFromCfg(322151121)
				local var_514_14 = arg_511_1:FormatText(var_514_13.content)

				arg_511_1.text_.text = var_514_14

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_16 = 19 <= 0 and var_514_11 or var_514_11 * (utf8.len(var_514_14) / 19)

				if (19 <= 0 and var_514_11 or var_514_11 * (utf8.len(var_514_14) / 19)) > 0 and var_514_11 < var_514_16 then
					arg_511_1.talkMaxDuration = var_514_16
					var_514_10 = var_514_10 + 0.3

					if var_514_16 + var_514_10 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_16 + var_514_10
					end
				end

				arg_511_1.text_.text = var_514_14
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151121", "story_v_out_322151.awb") ~= 0 then
					local var_514_17 = manager.audio:GetVoiceLength("story_v_out_322151", "322151121", "story_v_out_322151.awb") / 1000

					if var_514_17 + var_514_10 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_17 + var_514_10
					end

					if var_514_13.prefab_name ~= "" and arg_511_1.actors_[var_514_13.prefab_name] ~= nil then
						local var_514_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_13.prefab_name].transform, "story_v_out_322151", "322151121", "story_v_out_322151.awb")

						arg_511_1:RecordAudio("322151121", var_514_18)
						arg_511_1:RecordAudio("322151121", var_514_18)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_322151", "322151121", "story_v_out_322151.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_322151", "322151121", "story_v_out_322151.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_19 = var_514_10 + 0.3
			local var_514_20 = math.max(var_514_11, arg_511_1.talkMaxDuration)

			if var_514_10 + 0.3 <= arg_511_1.time_ and arg_511_1.time_ < var_514_19 + var_514_20 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_19) / var_514_20

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_19 + var_514_20 and arg_511_1.time_ < var_514_19 + var_514_20 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play322151122 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 322151122
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play322151123(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.425

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(322151122).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 17 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 17)

				if (17 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 17)) > 0 and var_520_0 < var_520_3 then
					arg_517_1.talkMaxDuration = var_520_3

					if var_520_3 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_3 + 0
					end
				end

				arg_517_1.text_.text = var_520_1
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_4 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_4

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play322151123 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 322151123
		arg_521_1.duration_ = 8.23

		local var_521_0 = {
			zh = 6.266,
			ja = 8.233
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play322151124(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.575

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:GetWordFromCfg(322151123)
				local var_524_2 = arg_521_1:FormatText(var_524_1.content)

				arg_521_1.text_.text = var_524_2

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_4 = 23 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 23)

				if (23 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_2) / 23)) > 0 and var_524_0 < var_524_4 then
					arg_521_1.talkMaxDuration = var_524_4

					if var_524_4 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_4 + 0
					end
				end

				arg_521_1.text_.text = var_524_2
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151123", "story_v_out_322151.awb") ~= 0 then
					local var_524_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151123", "story_v_out_322151.awb") / 1000

					if var_524_5 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_5 + 0
					end

					if var_524_1.prefab_name ~= "" and arg_521_1.actors_[var_524_1.prefab_name] ~= nil then
						local var_524_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_1.prefab_name].transform, "story_v_out_322151", "322151123", "story_v_out_322151.awb")

						arg_521_1:RecordAudio("322151123", var_524_6)
						arg_521_1:RecordAudio("322151123", var_524_6)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_322151", "322151123", "story_v_out_322151.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_322151", "322151123", "story_v_out_322151.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_7 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_7 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_7

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_7 and arg_521_1.time_ < 0 + var_524_7 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play322151124 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 322151124
		arg_525_1.duration_ = 9.3

		local var_525_0 = {
			zh = 9.3,
			ja = 6.2
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play322151125(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if arg_525_1.bgs_.ST61a == nil then
				local var_528_0 = Object.Instantiate(arg_525_1.paintGo_)

				var_528_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61a")
				var_528_0.name = "ST61a"
				var_528_0.transform.parent = arg_525_1.stage_.transform
				var_528_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.bgs_.ST61a = var_528_0
			end

			if 2 < arg_525_1.time_ and arg_525_1.time_ <= 2 + arg_528_0 then
				local var_528_1 = arg_525_1.bgs_.ST61a

				arg_525_1.bgs_.ST61a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_528_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_528_2 = var_528_1:GetComponent("SpriteRenderer")

				if var_528_2 and var_528_2.sprite then
					local var_528_3 = 2 * (var_528_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_528_1.transform.localScale = Vector3.New(var_528_3 / var_528_2.sprite.bounds.size.y < var_528_3 * manager.ui.mainCameraCom_.aspect / var_528_2.sprite.bounds.size.x and var_528_3 * manager.ui.mainCameraCom_.aspect / var_528_2.sprite.bounds.size.x or var_528_3 / var_528_2.sprite.bounds.size.y, var_528_3 / var_528_2.sprite.bounds.size.y < var_528_3 * manager.ui.mainCameraCom_.aspect / var_528_2.sprite.bounds.size.x and var_528_3 * manager.ui.mainCameraCom_.aspect / var_528_2.sprite.bounds.size.x or var_528_3 / var_528_2.sprite.bounds.size.y, 0)
				end

				for iter_528_0, iter_528_1 in pairs(arg_525_1.bgs_) do
					if iter_528_0 ~= "ST61a" then
						iter_528_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_528_4 = 4

			if 4 < arg_525_1.time_ and arg_525_1.time_ <= var_528_4 + arg_528_0 then
				arg_525_1.allBtn_.enabled = false
			end

			if arg_525_1.time_ >= var_528_4 + 0.3 and arg_525_1.time_ < var_528_4 + 0.3 + arg_528_0 then
				arg_525_1.allBtn_.enabled = true
			end

			local var_528_5 = 0

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_5 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_6 = 2

			if var_528_5 <= arg_525_1.time_ and arg_525_1.time_ < var_528_5 + var_528_6 then
				local var_528_7 = Color.New(0, 0, 0)

				var_528_7.a = Mathf.Lerp(0, 1, (arg_525_1.time_ - var_528_5) / var_528_6)
				arg_525_1.mask_.color = var_528_7
			end

			if arg_525_1.time_ >= var_528_5 + var_528_6 and arg_525_1.time_ < var_528_5 + var_528_6 + arg_528_0 then
				local var_528_8 = Color.New(0, 0, 0)

				var_528_8.a = 1
				arg_525_1.mask_.color = var_528_8
			end

			local var_528_9 = 2

			if 2 < arg_525_1.time_ and arg_525_1.time_ <= var_528_9 + arg_528_0 then
				arg_525_1.mask_.enabled = true
				arg_525_1.mask_.raycastTarget = true

				arg_525_1:SetGaussion(false)
			end

			local var_528_10 = 2

			if var_528_9 <= arg_525_1.time_ and arg_525_1.time_ < var_528_9 + var_528_10 then
				local var_528_11 = Color.New(0, 0, 0)

				var_528_11.a = Mathf.Lerp(1, 0, (arg_525_1.time_ - var_528_9) / var_528_10)
				arg_525_1.mask_.color = var_528_11
			end

			if arg_525_1.time_ >= var_528_9 + var_528_10 and arg_525_1.time_ < var_528_9 + var_528_10 + arg_528_0 then
				local var_528_12 = Color.New(0, 0, 0)

				arg_525_1.mask_.enabled = false
				var_528_12.a = 0
				arg_525_1.mask_.color = var_528_12
			end

			local var_528_13 = arg_525_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_525_1.time_ and arg_525_1.time_ <= 1.96599999815226 + arg_528_0 then
				arg_525_1.var_.moveOldPos1020ui_story = var_528_13.localPosition
			end

			local var_528_14 = 0.001

			if 1.96599999815226 <= arg_525_1.time_ and arg_525_1.time_ < 1.96599999815226 + var_528_14 then
				var_528_13.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_525_1.time_ - 1.96599999815226) / var_528_14)
				var_528_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_13.position).x, (manager.ui.mainCamera.transform.position - var_528_13.position).y, (manager.ui.mainCamera.transform.position - var_528_13.position).z)
				var_528_13.localEulerAngles.z = 0
				var_528_13.localEulerAngles.x = 0
				var_528_13.localEulerAngles = var_528_13.localEulerAngles
			end

			if arg_525_1.time_ >= 1.96599999815226 + var_528_14 and arg_525_1.time_ < 1.96599999815226 + var_528_14 + arg_528_0 then
				var_528_13.localPosition = Vector3.New(0, 100, 0)
				var_528_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_13.position).x, (manager.ui.mainCamera.transform.position - var_528_13.position).y, (manager.ui.mainCamera.transform.position - var_528_13.position).z)
				var_528_13.localEulerAngles.z = 0
				var_528_13.localEulerAngles.x = 0
				var_528_13.localEulerAngles = var_528_13.localEulerAngles
			end

			local var_528_15 = "10100ui_story"

			if arg_525_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_528_16 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_525_1.stage_.transform)

				var_528_16.name = var_528_15
				var_528_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_525_1.actors_[var_528_15] = var_528_16

				local var_528_17 = var_528_16:GetComponentInChildren(typeof(CharacterEffect))

				var_528_17.enabled = true

				local var_528_18 = GameObjectTools.GetOrAddComponent(var_528_16, typeof(DynamicBoneHelper))

				if var_528_18 then
					var_528_18:EnableDynamicBone(false)
				end

				arg_525_1:ShowWeapon(var_528_17.transform, false)

				arg_525_1.var_[var_528_15 .. "Animator"] = var_528_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_525_1.var_[var_528_15 .. "Animator"].applyRootMotion = true
				arg_525_1.var_[var_528_15 .. "LipSync"] = var_528_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_528_19 = arg_525_1.actors_["10100ui_story"].transform

			if 3.8 < arg_525_1.time_ and arg_525_1.time_ <= 3.8 + arg_528_0 then
				arg_525_1.var_.moveOldPos10100ui_story = var_528_19.localPosition
			end

			local var_528_20 = 0.001

			if 3.8 <= arg_525_1.time_ and arg_525_1.time_ < 3.8 + var_528_20 then
				var_528_19.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_525_1.time_ - 3.8) / var_528_20)
				var_528_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_19.position).x, (manager.ui.mainCamera.transform.position - var_528_19.position).y, (manager.ui.mainCamera.transform.position - var_528_19.position).z)
				var_528_19.localEulerAngles.z = 0
				var_528_19.localEulerAngles.x = 0
				var_528_19.localEulerAngles = var_528_19.localEulerAngles
			end

			if arg_525_1.time_ >= 3.8 + var_528_20 and arg_525_1.time_ < 3.8 + var_528_20 + arg_528_0 then
				var_528_19.localPosition = Vector3.New(0, -1.16, -6.25)
				var_528_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_19.position).x, (manager.ui.mainCamera.transform.position - var_528_19.position).y, (manager.ui.mainCamera.transform.position - var_528_19.position).z)
				var_528_19.localEulerAngles.z = 0
				var_528_19.localEulerAngles.x = 0
				var_528_19.localEulerAngles = var_528_19.localEulerAngles
			end

			local var_528_21 = arg_525_1.actors_["10100ui_story"]

			if 3.8 < arg_525_1.time_ and arg_525_1.time_ <= 3.8 + arg_528_0 and not isNil(var_528_21) and arg_525_1.var_.characterEffect10100ui_story == nil then
				arg_525_1.var_.characterEffect10100ui_story = var_528_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_22 = 0.200000002980232

			if 3.8 <= arg_525_1.time_ and arg_525_1.time_ < 3.8 + var_528_22 and not isNil(var_528_21) then
				if arg_525_1.var_.characterEffect10100ui_story and not isNil(var_528_21) then
					arg_525_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 3.8 + var_528_22 and arg_525_1.time_ < 3.8 + var_528_22 + arg_528_0 and not isNil(var_528_21) and arg_525_1.var_.characterEffect10100ui_story then
				arg_525_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 3.8 < arg_525_1.time_ and arg_525_1.time_ <= 3.8 + arg_528_0 then
				arg_525_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action24_1")
			end

			if 3.8 < arg_525_1.time_ and arg_525_1.time_ <= 3.8 + arg_528_0 then
				arg_525_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.3 < arg_525_1.time_ and arg_525_1.time_ <= 0.3 + arg_528_0 then
				arg_525_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_gold_rain", "")
			end

			if 1.53333333333333 < arg_525_1.time_ and arg_525_1.time_ <= 1.53333333333333 + arg_528_0 then
				arg_525_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 2 < arg_525_1.time_ and arg_525_1.time_ <= 2 + arg_528_0 then
				if arg_525_1.var_.effect1116 then
					Object.Destroy(arg_525_1.var_.effect1116)

					arg_525_1.var_.effect1116 = nil
				end
			end

			if arg_525_1.frameCnt_ <= 1 then
				arg_525_1.dialog_:SetActive(false)
			end

			local var_528_27 = 3.8
			local var_528_28 = 0.1

			if 3.8 < arg_525_1.time_ and arg_525_1.time_ <= var_528_27 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0

				arg_525_1.dialog_:SetActive(true)

				arg_525_1.dialogCg_.alpha = 0

				local var_528_29 = LeanTween.value(arg_525_1.dialog_, 0, 1, 0.3)

				var_528_29:setOnUpdate(LuaHelper.FloatAction(function(arg_529_0)
					arg_525_1.dialogCg_.alpha = arg_529_0
				end))
				var_528_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_525_1.dialog_)
					var_528_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_525_1.duration_ = arg_525_1.duration_ + 0.3

				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_30 = arg_525_1:GetWordFromCfg(322151124)
				local var_528_31 = arg_525_1:FormatText(var_528_30.content)

				arg_525_1.text_.text = var_528_31

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_33 = 4 <= 0 and var_528_28 or var_528_28 * (utf8.len(var_528_31) / 4)

				if (4 <= 0 and var_528_28 or var_528_28 * (utf8.len(var_528_31) / 4)) > 0 and var_528_28 < var_528_33 then
					arg_525_1.talkMaxDuration = var_528_33
					var_528_27 = var_528_27 + 0.3

					if var_528_33 + var_528_27 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_33 + var_528_27
					end
				end

				arg_525_1.text_.text = var_528_31
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151124", "story_v_out_322151.awb") ~= 0 then
					local var_528_34 = manager.audio:GetVoiceLength("story_v_out_322151", "322151124", "story_v_out_322151.awb") / 1000

					if var_528_34 + var_528_27 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_34 + var_528_27
					end

					if var_528_30.prefab_name ~= "" and arg_525_1.actors_[var_528_30.prefab_name] ~= nil then
						local var_528_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_30.prefab_name].transform, "story_v_out_322151", "322151124", "story_v_out_322151.awb")

						arg_525_1:RecordAudio("322151124", var_528_35)
						arg_525_1:RecordAudio("322151124", var_528_35)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_322151", "322151124", "story_v_out_322151.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_322151", "322151124", "story_v_out_322151.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_36 = var_528_27 + 0.3
			local var_528_37 = math.max(var_528_28, arg_525_1.talkMaxDuration)

			if var_528_27 + 0.3 <= arg_525_1.time_ and arg_525_1.time_ < var_528_36 + var_528_37 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_36) / var_528_37

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_36 + var_528_37 and arg_525_1.time_ < var_528_36 + var_528_37 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play322151125 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 322151125
		arg_531_1.duration_ = 6.5

		local var_531_0 = {
			zh = 6.5,
			ja = 4.3
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play322151126(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos10100ui_story = arg_531_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_534_0 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				arg_531_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_531_1.time_ - 0) / var_534_0)
				arg_531_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["10100ui_story"].transform.position).z)
				arg_531_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["10100ui_story"].transform.localEulerAngles = arg_531_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				arg_531_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(0, -1.16, -6.25)
				arg_531_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_531_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_531_1.actors_["10100ui_story"].transform.position).z)
				arg_531_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_531_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_531_1.actors_["10100ui_story"].transform.localEulerAngles = arg_531_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action24_2")
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_534_1 = 0
			local var_534_2 = 0.5

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_1 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_3 = arg_531_1:GetWordFromCfg(322151125)
				local var_534_4 = arg_531_1:FormatText(var_534_3.content)

				arg_531_1.text_.text = var_534_4

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_6 = 20 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_4) / 20)

				if (20 <= 0 and var_534_2 or var_534_2 * (utf8.len(var_534_4) / 20)) > 0 and var_534_2 < var_534_6 then
					arg_531_1.talkMaxDuration = var_534_6

					if var_534_6 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_6 + var_534_1
					end
				end

				arg_531_1.text_.text = var_534_4
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151125", "story_v_out_322151.awb") ~= 0 then
					local var_534_7 = manager.audio:GetVoiceLength("story_v_out_322151", "322151125", "story_v_out_322151.awb") / 1000

					if var_534_7 + var_534_1 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_1
					end

					if var_534_3.prefab_name ~= "" and arg_531_1.actors_[var_534_3.prefab_name] ~= nil then
						local var_534_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_3.prefab_name].transform, "story_v_out_322151", "322151125", "story_v_out_322151.awb")

						arg_531_1:RecordAudio("322151125", var_534_8)
						arg_531_1:RecordAudio("322151125", var_534_8)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_322151", "322151125", "story_v_out_322151.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_322151", "322151125", "story_v_out_322151.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_9 = math.max(var_534_2, arg_531_1.talkMaxDuration)

			if var_534_1 <= arg_531_1.time_ and arg_531_1.time_ < var_534_1 + var_534_9 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_1) / var_534_9

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_1 + var_534_9 and arg_531_1.time_ < var_534_1 + var_534_9 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play322151126 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 322151126
		arg_535_1.duration_ = 5.53

		local var_535_0 = {
			zh = 4.066,
			ja = 5.533
		}
		local var_535_1 = manager.audio:GetLocalizationFlag()

		if var_535_0[var_535_1] ~= nil then
			arg_535_1.duration_ = var_535_0[var_535_1]
		end

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play322151127(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos1089ui_story = arg_535_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_538_0 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 then
				arg_535_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_535_1.time_ - 0) / var_538_0)
				arg_535_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["1089ui_story"].transform.position).z)
				arg_535_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["1089ui_story"].transform.localEulerAngles = arg_535_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 then
				arg_535_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_535_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_535_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_535_1.actors_["1089ui_story"].transform.position).z)
				arg_535_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_535_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_535_1.actors_["1089ui_story"].transform.localEulerAngles = arg_535_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_538_1 = arg_535_1.actors_["10100ui_story"].transform

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.var_.moveOldPos10100ui_story = var_538_1.localPosition
			end

			local var_538_2 = 0.001

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_2 then
				var_538_1.localPosition = Vector3.Lerp(arg_535_1.var_.moveOldPos10100ui_story, Vector3.New(-0.7, -1.16, -6.25), (arg_535_1.time_ - 0) / var_538_2)
				var_538_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_1.position).x, (manager.ui.mainCamera.transform.position - var_538_1.position).y, (manager.ui.mainCamera.transform.position - var_538_1.position).z)
				var_538_1.localEulerAngles.z = 0
				var_538_1.localEulerAngles.x = 0
				var_538_1.localEulerAngles = var_538_1.localEulerAngles
			end

			if arg_535_1.time_ >= 0 + var_538_2 and arg_535_1.time_ < 0 + var_538_2 + arg_538_0 then
				var_538_1.localPosition = Vector3.New(-0.7, -1.16, -6.25)
				var_538_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_538_1.position).x, (manager.ui.mainCamera.transform.position - var_538_1.position).y, (manager.ui.mainCamera.transform.position - var_538_1.position).z)
				var_538_1.localEulerAngles.z = 0
				var_538_1.localEulerAngles.x = 0
				var_538_1.localEulerAngles = var_538_1.localEulerAngles
			end

			local var_538_3 = arg_535_1.actors_["1089ui_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_3) and arg_535_1.var_.characterEffect1089ui_story == nil then
				arg_535_1.var_.characterEffect1089ui_story = var_538_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_4 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_4 and not isNil(var_538_3) then
				if arg_535_1.var_.characterEffect1089ui_story and not isNil(var_538_3) then
					arg_535_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_535_1.time_ >= 0 + var_538_4 and arg_535_1.time_ < 0 + var_538_4 + arg_538_0 and not isNil(var_538_3) and arg_535_1.var_.characterEffect1089ui_story then
				arg_535_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_538_6 = arg_535_1.actors_["10100ui_story"]

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(var_538_6) and arg_535_1.var_.characterEffect10100ui_story == nil then
				arg_535_1.var_.characterEffect10100ui_story = var_538_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_538_7 = 0.200000002980232

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_7 and not isNil(var_538_6) then
				if arg_535_1.var_.characterEffect10100ui_story and not isNil(var_538_6) then
					arg_535_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_535_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_535_1.time_ - 0) / var_538_7)
				end
			end

			if arg_535_1.time_ >= 0 + var_538_7 and arg_535_1.time_ < 0 + var_538_7 + arg_538_0 and not isNil(var_538_6) and arg_535_1.var_.characterEffect10100ui_story then
				arg_535_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_535_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_538_8 = 0
			local var_538_9 = 0.325

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_8 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, false)
				arg_535_1.callingController_:SetSelectedState("normal")

				local var_538_10 = arg_535_1:GetWordFromCfg(322151126)
				local var_538_11 = arg_535_1:FormatText(var_538_10.content)

				arg_535_1.text_.text = var_538_11

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_13 = 13 <= 0 and var_538_9 or var_538_9 * (utf8.len(var_538_11) / 13)

				if (13 <= 0 and var_538_9 or var_538_9 * (utf8.len(var_538_11) / 13)) > 0 and var_538_9 < var_538_13 then
					arg_535_1.talkMaxDuration = var_538_13

					if var_538_13 + var_538_8 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_13 + var_538_8
					end
				end

				arg_535_1.text_.text = var_538_11
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151126", "story_v_out_322151.awb") ~= 0 then
					local var_538_14 = manager.audio:GetVoiceLength("story_v_out_322151", "322151126", "story_v_out_322151.awb") / 1000

					if var_538_14 + var_538_8 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_14 + var_538_8
					end

					if var_538_10.prefab_name ~= "" and arg_535_1.actors_[var_538_10.prefab_name] ~= nil then
						local var_538_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_10.prefab_name].transform, "story_v_out_322151", "322151126", "story_v_out_322151.awb")

						arg_535_1:RecordAudio("322151126", var_538_15)
						arg_535_1:RecordAudio("322151126", var_538_15)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_out_322151", "322151126", "story_v_out_322151.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_out_322151", "322151126", "story_v_out_322151.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_16 = math.max(var_538_9, arg_535_1.talkMaxDuration)

			if var_538_8 <= arg_535_1.time_ and arg_535_1.time_ < var_538_8 + var_538_16 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_8) / var_538_16

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_8 + var_538_16 and arg_535_1.time_ < var_538_8 + var_538_16 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_535_1:InitPlayNodeList()
	end,
	Play322151127 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 322151127
		arg_539_1.duration_ = 9.2

		local var_539_0 = {
			zh = 6.4,
			ja = 9.2
		}
		local var_539_1 = manager.audio:GetLocalizationFlag()

		if var_539_0[var_539_1] ~= nil then
			arg_539_1.duration_ = var_539_0[var_539_1]
		end

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play322151128(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.var_.moveOldPos10100ui_story = arg_539_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_542_0 = 0.001

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_0 then
				arg_539_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_539_1.var_.moveOldPos10100ui_story, Vector3.New(-0.7, -1.16, -6.25), (arg_539_1.time_ - 0) / var_542_0)
				arg_539_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["10100ui_story"].transform.position).z)
				arg_539_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["10100ui_story"].transform.localEulerAngles = arg_539_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_539_1.time_ >= 0 + var_542_0 and arg_539_1.time_ < 0 + var_542_0 + arg_542_0 then
				arg_539_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(-0.7, -1.16, -6.25)
				arg_539_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_539_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_539_1.actors_["10100ui_story"].transform.position).z)
				arg_539_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_539_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_539_1.actors_["10100ui_story"].transform.localEulerAngles = arg_539_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_542_1 = arg_539_1.actors_["10100ui_story"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_1) and arg_539_1.var_.characterEffect10100ui_story == nil then
				arg_539_1.var_.characterEffect10100ui_story = var_542_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_2 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_2 and not isNil(var_542_1) then
				if arg_539_1.var_.characterEffect10100ui_story and not isNil(var_542_1) then
					arg_539_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_539_1.time_ >= 0 + var_542_2 and arg_539_1.time_ < 0 + var_542_2 + arg_542_0 and not isNil(var_542_1) and arg_539_1.var_.characterEffect10100ui_story then
				arg_539_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_542_4 = arg_539_1.actors_["1089ui_story"]

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 and not isNil(var_542_4) and arg_539_1.var_.characterEffect1089ui_story == nil then
				arg_539_1.var_.characterEffect1089ui_story = var_542_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_542_5 = 0.200000002980232

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_5 and not isNil(var_542_4) then
				if arg_539_1.var_.characterEffect1089ui_story and not isNil(var_542_4) then
					arg_539_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_539_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_539_1.time_ - 0) / var_542_5)
				end
			end

			if arg_539_1.time_ >= 0 + var_542_5 and arg_539_1.time_ < 0 + var_542_5 + arg_542_0 and not isNil(var_542_4) and arg_539_1.var_.characterEffect1089ui_story then
				arg_539_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_539_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action20_1")
			end

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_542_6 = 0
			local var_542_7 = 0.6

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_6 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, false)
				arg_539_1.callingController_:SetSelectedState("normal")

				local var_542_8 = arg_539_1:GetWordFromCfg(322151127)
				local var_542_9 = arg_539_1:FormatText(var_542_8.content)

				arg_539_1.text_.text = var_542_9

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_11 = 24 <= 0 and var_542_7 or var_542_7 * (utf8.len(var_542_9) / 24)

				if (24 <= 0 and var_542_7 or var_542_7 * (utf8.len(var_542_9) / 24)) > 0 and var_542_7 < var_542_11 then
					arg_539_1.talkMaxDuration = var_542_11

					if var_542_11 + var_542_6 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_11 + var_542_6
					end
				end

				arg_539_1.text_.text = var_542_9
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151127", "story_v_out_322151.awb") ~= 0 then
					local var_542_12 = manager.audio:GetVoiceLength("story_v_out_322151", "322151127", "story_v_out_322151.awb") / 1000

					if var_542_12 + var_542_6 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_12 + var_542_6
					end

					if var_542_8.prefab_name ~= "" and arg_539_1.actors_[var_542_8.prefab_name] ~= nil then
						local var_542_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_8.prefab_name].transform, "story_v_out_322151", "322151127", "story_v_out_322151.awb")

						arg_539_1:RecordAudio("322151127", var_542_13)
						arg_539_1:RecordAudio("322151127", var_542_13)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_out_322151", "322151127", "story_v_out_322151.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_out_322151", "322151127", "story_v_out_322151.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_14 = math.max(var_542_7, arg_539_1.talkMaxDuration)

			if var_542_6 <= arg_539_1.time_ and arg_539_1.time_ < var_542_6 + var_542_14 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_6) / var_542_14

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_6 + var_542_14 and arg_539_1.time_ < var_542_6 + var_542_14 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_539_1:InitPlayNodeList()
	end,
	Play322151128 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 322151128
		arg_543_1.duration_ = 11.2

		local var_543_0 = {
			zh = 11.2,
			ja = 6.5
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play322151129(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if arg_543_1.bgs_.L08f == nil then
				local var_546_0 = Object.Instantiate(arg_543_1.paintGo_)

				var_546_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L08f")
				var_546_0.name = "L08f"
				var_546_0.transform.parent = arg_543_1.stage_.transform
				var_546_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_543_1.bgs_.L08f = var_546_0
			end

			if 2 < arg_543_1.time_ and arg_543_1.time_ <= 2 + arg_546_0 then
				local var_546_1 = arg_543_1.bgs_.L08f

				arg_543_1.bgs_.L08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_546_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_546_2 = var_546_1:GetComponent("SpriteRenderer")

				if var_546_2 and var_546_2.sprite then
					local var_546_3 = 2 * (var_546_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_546_1.transform.localScale = Vector3.New(var_546_3 / var_546_2.sprite.bounds.size.y < var_546_3 * manager.ui.mainCameraCom_.aspect / var_546_2.sprite.bounds.size.x and var_546_3 * manager.ui.mainCameraCom_.aspect / var_546_2.sprite.bounds.size.x or var_546_3 / var_546_2.sprite.bounds.size.y, var_546_3 / var_546_2.sprite.bounds.size.y < var_546_3 * manager.ui.mainCameraCom_.aspect / var_546_2.sprite.bounds.size.x and var_546_3 * manager.ui.mainCameraCom_.aspect / var_546_2.sprite.bounds.size.x or var_546_3 / var_546_2.sprite.bounds.size.y, 0)
				end

				for iter_546_0, iter_546_1 in pairs(arg_543_1.bgs_) do
					if iter_546_0 ~= "L08f" then
						iter_546_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_546_4 = 4

			if 4 < arg_543_1.time_ and arg_543_1.time_ <= var_546_4 + arg_546_0 then
				arg_543_1.allBtn_.enabled = false
			end

			if arg_543_1.time_ >= var_546_4 + 0.3 and arg_543_1.time_ < var_546_4 + 0.3 + arg_546_0 then
				arg_543_1.allBtn_.enabled = true
			end

			local var_546_5 = 0

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_5 + arg_546_0 then
				arg_543_1.mask_.enabled = true
				arg_543_1.mask_.raycastTarget = true

				arg_543_1:SetGaussion(false)
			end

			local var_546_6 = 2

			if var_546_5 <= arg_543_1.time_ and arg_543_1.time_ < var_546_5 + var_546_6 then
				local var_546_7 = Color.New(0, 0, 0)

				var_546_7.a = Mathf.Lerp(0, 1, (arg_543_1.time_ - var_546_5) / var_546_6)
				arg_543_1.mask_.color = var_546_7
			end

			if arg_543_1.time_ >= var_546_5 + var_546_6 and arg_543_1.time_ < var_546_5 + var_546_6 + arg_546_0 then
				local var_546_8 = Color.New(0, 0, 0)

				var_546_8.a = 1
				arg_543_1.mask_.color = var_546_8
			end

			local var_546_9 = 2

			if 2 < arg_543_1.time_ and arg_543_1.time_ <= var_546_9 + arg_546_0 then
				arg_543_1.mask_.enabled = true
				arg_543_1.mask_.raycastTarget = true

				arg_543_1:SetGaussion(false)
			end

			local var_546_10 = 2

			if var_546_9 <= arg_543_1.time_ and arg_543_1.time_ < var_546_9 + var_546_10 then
				local var_546_11 = Color.New(0, 0, 0)

				var_546_11.a = Mathf.Lerp(1, 0, (arg_543_1.time_ - var_546_9) / var_546_10)
				arg_543_1.mask_.color = var_546_11
			end

			if arg_543_1.time_ >= var_546_9 + var_546_10 and arg_543_1.time_ < var_546_9 + var_546_10 + arg_546_0 then
				local var_546_12 = Color.New(0, 0, 0)

				arg_543_1.mask_.enabled = false
				var_546_12.a = 0
				arg_543_1.mask_.color = var_546_12
			end

			local var_546_13 = arg_543_1.actors_["10100ui_story"].transform

			if 1.96599999815226 < arg_543_1.time_ and arg_543_1.time_ <= 1.96599999815226 + arg_546_0 then
				arg_543_1.var_.moveOldPos10100ui_story = var_546_13.localPosition
			end

			local var_546_14 = 0.001

			if 1.96599999815226 <= arg_543_1.time_ and arg_543_1.time_ < 1.96599999815226 + var_546_14 then
				var_546_13.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_543_1.time_ - 1.96599999815226) / var_546_14)
				var_546_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_13.position).x, (manager.ui.mainCamera.transform.position - var_546_13.position).y, (manager.ui.mainCamera.transform.position - var_546_13.position).z)
				var_546_13.localEulerAngles.z = 0
				var_546_13.localEulerAngles.x = 0
				var_546_13.localEulerAngles = var_546_13.localEulerAngles
			end

			if arg_543_1.time_ >= 1.96599999815226 + var_546_14 and arg_543_1.time_ < 1.96599999815226 + var_546_14 + arg_546_0 then
				var_546_13.localPosition = Vector3.New(0, 100, 0)
				var_546_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_13.position).x, (manager.ui.mainCamera.transform.position - var_546_13.position).y, (manager.ui.mainCamera.transform.position - var_546_13.position).z)
				var_546_13.localEulerAngles.z = 0
				var_546_13.localEulerAngles.x = 0
				var_546_13.localEulerAngles = var_546_13.localEulerAngles
			end

			local var_546_15 = arg_543_1.actors_["1089ui_story"].transform

			if 1.96599999815226 < arg_543_1.time_ and arg_543_1.time_ <= 1.96599999815226 + arg_546_0 then
				arg_543_1.var_.moveOldPos1089ui_story = var_546_15.localPosition
			end

			local var_546_16 = 0.001

			if 1.96599999815226 <= arg_543_1.time_ and arg_543_1.time_ < 1.96599999815226 + var_546_16 then
				var_546_15.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_543_1.time_ - 1.96599999815226) / var_546_16)
				var_546_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_15.position).x, (manager.ui.mainCamera.transform.position - var_546_15.position).y, (manager.ui.mainCamera.transform.position - var_546_15.position).z)
				var_546_15.localEulerAngles.z = 0
				var_546_15.localEulerAngles.x = 0
				var_546_15.localEulerAngles = var_546_15.localEulerAngles
			end

			if arg_543_1.time_ >= 1.96599999815226 + var_546_16 and arg_543_1.time_ < 1.96599999815226 + var_546_16 + arg_546_0 then
				var_546_15.localPosition = Vector3.New(0, 100, 0)
				var_546_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_15.position).x, (manager.ui.mainCamera.transform.position - var_546_15.position).y, (manager.ui.mainCamera.transform.position - var_546_15.position).z)
				var_546_15.localEulerAngles.z = 0
				var_546_15.localEulerAngles.x = 0
				var_546_15.localEulerAngles = var_546_15.localEulerAngles
			end

			local var_546_17 = "1052ui_story"

			if arg_543_1.actors_["1052ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1052ui_story"))) then
				local var_546_18 = Object.Instantiate(Asset.Load("Char/" .. "1052ui_story"), arg_543_1.stage_.transform)

				var_546_18.name = var_546_17
				var_546_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_543_1.actors_[var_546_17] = var_546_18

				local var_546_19 = var_546_18:GetComponentInChildren(typeof(CharacterEffect))

				var_546_19.enabled = true

				local var_546_20 = GameObjectTools.GetOrAddComponent(var_546_18, typeof(DynamicBoneHelper))

				if var_546_20 then
					var_546_20:EnableDynamicBone(false)
				end

				arg_543_1:ShowWeapon(var_546_19.transform, false)

				arg_543_1.var_[var_546_17 .. "Animator"] = var_546_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_543_1.var_[var_546_17 .. "Animator"].applyRootMotion = true
				arg_543_1.var_[var_546_17 .. "LipSync"] = var_546_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_546_21 = arg_543_1.actors_["1052ui_story"].transform

			if 3.8 < arg_543_1.time_ and arg_543_1.time_ <= 3.8 + arg_546_0 then
				arg_543_1.var_.moveOldPos1052ui_story = var_546_21.localPosition
			end

			local var_546_22 = 0.001

			if 3.8 <= arg_543_1.time_ and arg_543_1.time_ < 3.8 + var_546_22 then
				var_546_21.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1052ui_story, Vector3.New(0, -1.05, -6.2), (arg_543_1.time_ - 3.8) / var_546_22)
				var_546_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_21.position).x, (manager.ui.mainCamera.transform.position - var_546_21.position).y, (manager.ui.mainCamera.transform.position - var_546_21.position).z)
				var_546_21.localEulerAngles.z = 0
				var_546_21.localEulerAngles.x = 0
				var_546_21.localEulerAngles = var_546_21.localEulerAngles
			end

			if arg_543_1.time_ >= 3.8 + var_546_22 and arg_543_1.time_ < 3.8 + var_546_22 + arg_546_0 then
				var_546_21.localPosition = Vector3.New(0, -1.05, -6.2)
				var_546_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_546_21.position).x, (manager.ui.mainCamera.transform.position - var_546_21.position).y, (manager.ui.mainCamera.transform.position - var_546_21.position).z)
				var_546_21.localEulerAngles.z = 0
				var_546_21.localEulerAngles.x = 0
				var_546_21.localEulerAngles = var_546_21.localEulerAngles
			end

			local var_546_23 = arg_543_1.actors_["1052ui_story"]

			if 3.8 < arg_543_1.time_ and arg_543_1.time_ <= 3.8 + arg_546_0 and not isNil(var_546_23) and arg_543_1.var_.characterEffect1052ui_story == nil then
				arg_543_1.var_.characterEffect1052ui_story = var_546_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_24 = 0.200000002980232

			if 3.8 <= arg_543_1.time_ and arg_543_1.time_ < 3.8 + var_546_24 and not isNil(var_546_23) then
				if arg_543_1.var_.characterEffect1052ui_story and not isNil(var_546_23) then
					arg_543_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= 3.8 + var_546_24 and arg_543_1.time_ < 3.8 + var_546_24 + arg_546_0 and not isNil(var_546_23) and arg_543_1.var_.characterEffect1052ui_story then
				arg_543_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 3.8 < arg_543_1.time_ and arg_543_1.time_ <= 3.8 + arg_546_0 then
				arg_543_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action1_1")
			end

			if 3.8 < arg_543_1.time_ and arg_543_1.time_ <= 3.8 + arg_546_0 then
				arg_543_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_543_1.time_ and arg_543_1.time_ <= 0.2 + arg_546_0 then
				arg_543_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 1.53333333333333 < arg_543_1.time_ and arg_543_1.time_ <= 1.53333333333333 + arg_546_0 then
				arg_543_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_543_1.frameCnt_ <= 1 then
				arg_543_1.dialog_:SetActive(false)
			end

			local var_546_28 = 4
			local var_546_29 = 0.25

			if 4 < arg_543_1.time_ and arg_543_1.time_ <= var_546_28 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0

				arg_543_1.dialog_:SetActive(true)

				arg_543_1.dialogCg_.alpha = 0

				local var_546_30 = LeanTween.value(arg_543_1.dialog_, 0, 1, 0.3)

				var_546_30:setOnUpdate(LuaHelper.FloatAction(function(arg_547_0)
					arg_543_1.dialogCg_.alpha = arg_547_0
				end))
				var_546_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_543_1.dialog_)
					var_546_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_543_1.duration_ = arg_543_1.duration_ + 0.3

				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_31 = arg_543_1:GetWordFromCfg(322151128)
				local var_546_32 = arg_543_1:FormatText(var_546_31.content)

				arg_543_1.text_.text = var_546_32

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_34 = 10 <= 0 and var_546_29 or var_546_29 * (utf8.len(var_546_32) / 10)

				if (10 <= 0 and var_546_29 or var_546_29 * (utf8.len(var_546_32) / 10)) > 0 and var_546_29 < var_546_34 then
					arg_543_1.talkMaxDuration = var_546_34
					var_546_28 = var_546_28 + 0.3

					if var_546_34 + var_546_28 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_34 + var_546_28
					end
				end

				arg_543_1.text_.text = var_546_32
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151128", "story_v_out_322151.awb") ~= 0 then
					local var_546_35 = manager.audio:GetVoiceLength("story_v_out_322151", "322151128", "story_v_out_322151.awb") / 1000

					if var_546_35 + var_546_28 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_35 + var_546_28
					end

					if var_546_31.prefab_name ~= "" and arg_543_1.actors_[var_546_31.prefab_name] ~= nil then
						local var_546_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_31.prefab_name].transform, "story_v_out_322151", "322151128", "story_v_out_322151.awb")

						arg_543_1:RecordAudio("322151128", var_546_36)
						arg_543_1:RecordAudio("322151128", var_546_36)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_322151", "322151128", "story_v_out_322151.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_322151", "322151128", "story_v_out_322151.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_37 = var_546_28 + 0.3
			local var_546_38 = math.max(var_546_29, arg_543_1.talkMaxDuration)

			if var_546_28 + 0.3 <= arg_543_1.time_ and arg_543_1.time_ < var_546_37 + var_546_38 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_37) / var_546_38

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_37 + var_546_38 and arg_543_1.time_ < var_546_37 + var_546_38 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play322151129 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 322151129
		arg_549_1.duration_ = 2.8

		local var_549_0 = {
			zh = 2.333,
			ja = 2.8
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play322151130(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action5_1")
			end

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_552_0 = 0
			local var_552_1 = 0.25

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_2 = arg_549_1:GetWordFromCfg(322151129)
				local var_552_3 = arg_549_1:FormatText(var_552_2.content)

				arg_549_1.text_.text = var_552_3

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_5 = 10 <= 0 and var_552_1 or var_552_1 * (utf8.len(var_552_3) / 10)

				if (10 <= 0 and var_552_1 or var_552_1 * (utf8.len(var_552_3) / 10)) > 0 and var_552_1 < var_552_5 then
					arg_549_1.talkMaxDuration = var_552_5

					if var_552_5 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + var_552_0
					end
				end

				arg_549_1.text_.text = var_552_3
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151129", "story_v_out_322151.awb") ~= 0 then
					local var_552_6 = manager.audio:GetVoiceLength("story_v_out_322151", "322151129", "story_v_out_322151.awb") / 1000

					if var_552_6 + var_552_0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_6 + var_552_0
					end

					if var_552_2.prefab_name ~= "" and arg_549_1.actors_[var_552_2.prefab_name] ~= nil then
						local var_552_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_2.prefab_name].transform, "story_v_out_322151", "322151129", "story_v_out_322151.awb")

						arg_549_1:RecordAudio("322151129", var_552_7)
						arg_549_1:RecordAudio("322151129", var_552_7)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_322151", "322151129", "story_v_out_322151.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_322151", "322151129", "story_v_out_322151.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_8 = math.max(var_552_1, arg_549_1.talkMaxDuration)

			if var_552_0 <= arg_549_1.time_ and arg_549_1.time_ < var_552_0 + var_552_8 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_0) / var_552_8

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_0 + var_552_8 and arg_549_1.time_ < var_552_0 + var_552_8 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play322151130 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 322151130
		arg_553_1.duration_ = 4.3

		local var_553_0 = {
			zh = 2.966,
			ja = 4.3
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play322151131(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1052ui_story"]) and arg_553_1.var_.characterEffect1052ui_story == nil then
				arg_553_1.var_.characterEffect1052ui_story = arg_553_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.200000002980232

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1052ui_story"]) then
				if arg_553_1.var_.characterEffect1052ui_story and not isNil(arg_553_1.actors_["1052ui_story"]) then
					arg_553_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_553_1.time_ - 0) / var_556_0)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1052ui_story"]) and arg_553_1.var_.characterEffect1052ui_story then
				arg_553_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			local var_556_1 = 0
			local var_556_2 = 0.35

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, true)
				arg_553_1.iconController_:SetSelectedState("hero")

				arg_553_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_553_1.callingController_:SetSelectedState("normal")

				arg_553_1.keyicon_.color = Color.New(1, 1, 1)
				arg_553_1.icon_.color = Color.New(1, 1, 1)

				local var_556_3 = arg_553_1:GetWordFromCfg(322151130)
				local var_556_4 = arg_553_1:FormatText(var_556_3.content)

				arg_553_1.text_.text = var_556_4

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_6 = 14 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_4) / 14)

				if (14 <= 0 and var_556_2 or var_556_2 * (utf8.len(var_556_4) / 14)) > 0 and var_556_2 < var_556_6 then
					arg_553_1.talkMaxDuration = var_556_6

					if var_556_6 + var_556_1 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_6 + var_556_1
					end
				end

				arg_553_1.text_.text = var_556_4
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151130", "story_v_out_322151.awb") ~= 0 then
					local var_556_7 = manager.audio:GetVoiceLength("story_v_out_322151", "322151130", "story_v_out_322151.awb") / 1000

					if var_556_7 + var_556_1 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_7 + var_556_1
					end

					if var_556_3.prefab_name ~= "" and arg_553_1.actors_[var_556_3.prefab_name] ~= nil then
						local var_556_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_3.prefab_name].transform, "story_v_out_322151", "322151130", "story_v_out_322151.awb")

						arg_553_1:RecordAudio("322151130", var_556_8)
						arg_553_1:RecordAudio("322151130", var_556_8)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_322151", "322151130", "story_v_out_322151.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_322151", "322151130", "story_v_out_322151.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_9 = math.max(var_556_2, arg_553_1.talkMaxDuration)

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_9 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_1) / var_556_9

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_1 + var_556_9 and arg_553_1.time_ < var_556_1 + var_556_9 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play322151131 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 322151131
		arg_557_1.duration_ = 8.33

		local var_557_0 = {
			zh = 8.333,
			ja = 6.366
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play322151132(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["1052ui_story"]) and arg_557_1.var_.characterEffect1052ui_story == nil then
				arg_557_1.var_.characterEffect1052ui_story = arg_557_1.actors_["1052ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_0 = 0.200000002980232

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["1052ui_story"]) then
				if arg_557_1.var_.characterEffect1052ui_story and not isNil(arg_557_1.actors_["1052ui_story"]) then
					arg_557_1.var_.characterEffect1052ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["1052ui_story"]) and arg_557_1.var_.characterEffect1052ui_story then
				arg_557_1.var_.characterEffect1052ui_story.fillFlat = false
			end

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/story1052/story1052action/1052action5_2")
			end

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1:PlayTimeline("1052ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_560_2 = 0
			local var_560_3 = 0.5

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_2 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[263].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_4 = arg_557_1:GetWordFromCfg(322151131)
				local var_560_5 = arg_557_1:FormatText(var_560_4.content)

				arg_557_1.text_.text = var_560_5

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_7 = 20 <= 0 and var_560_3 or var_560_3 * (utf8.len(var_560_5) / 20)

				if (20 <= 0 and var_560_3 or var_560_3 * (utf8.len(var_560_5) / 20)) > 0 and var_560_3 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_2 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_2
					end
				end

				arg_557_1.text_.text = var_560_5
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151131", "story_v_out_322151.awb") ~= 0 then
					local var_560_8 = manager.audio:GetVoiceLength("story_v_out_322151", "322151131", "story_v_out_322151.awb") / 1000

					if var_560_8 + var_560_2 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_8 + var_560_2
					end

					if var_560_4.prefab_name ~= "" and arg_557_1.actors_[var_560_4.prefab_name] ~= nil then
						local var_560_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_4.prefab_name].transform, "story_v_out_322151", "322151131", "story_v_out_322151.awb")

						arg_557_1:RecordAudio("322151131", var_560_9)
						arg_557_1:RecordAudio("322151131", var_560_9)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_322151", "322151131", "story_v_out_322151.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_322151", "322151131", "story_v_out_322151.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_10 = math.max(var_560_3, arg_557_1.talkMaxDuration)

			if var_560_2 <= arg_557_1.time_ and arg_557_1.time_ < var_560_2 + var_560_10 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_2) / var_560_10

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_2 + var_560_10 and arg_557_1.time_ < var_560_2 + var_560_10 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play322151132 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 322151132
		arg_561_1.duration_ = 6.73

		local var_561_0 = {
			zh = 6.6,
			ja = 6.733
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play322151133(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if arg_561_1.bgs_.ST0507a == nil then
				local var_564_0 = Object.Instantiate(arg_561_1.paintGo_)

				var_564_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0507a")
				var_564_0.name = "ST0507a"
				var_564_0.transform.parent = arg_561_1.stage_.transform
				var_564_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_561_1.bgs_.ST0507a = var_564_0
			end

			if 2 < arg_561_1.time_ and arg_561_1.time_ <= 2 + arg_564_0 then
				local var_564_1 = arg_561_1.bgs_.ST0507a

				arg_561_1.bgs_.ST0507a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_564_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_564_2 = var_564_1:GetComponent("SpriteRenderer")

				if var_564_2 and var_564_2.sprite then
					local var_564_3 = 2 * (var_564_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_564_1.transform.localScale = Vector3.New(var_564_3 / var_564_2.sprite.bounds.size.y < var_564_3 * manager.ui.mainCameraCom_.aspect / var_564_2.sprite.bounds.size.x and var_564_3 * manager.ui.mainCameraCom_.aspect / var_564_2.sprite.bounds.size.x or var_564_3 / var_564_2.sprite.bounds.size.y, var_564_3 / var_564_2.sprite.bounds.size.y < var_564_3 * manager.ui.mainCameraCom_.aspect / var_564_2.sprite.bounds.size.x and var_564_3 * manager.ui.mainCameraCom_.aspect / var_564_2.sprite.bounds.size.x or var_564_3 / var_564_2.sprite.bounds.size.y, 0)
				end

				for iter_564_0, iter_564_1 in pairs(arg_561_1.bgs_) do
					if iter_564_0 ~= "ST0507a" then
						iter_564_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_564_4 = 4

			if 4 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.allBtn_.enabled = false
			end

			if arg_561_1.time_ >= var_564_4 + 0.3 and arg_561_1.time_ < var_564_4 + 0.3 + arg_564_0 then
				arg_561_1.allBtn_.enabled = true
			end

			local var_564_5 = 0

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_5 + arg_564_0 then
				arg_561_1.mask_.enabled = true
				arg_561_1.mask_.raycastTarget = true

				arg_561_1:SetGaussion(false)
			end

			local var_564_6 = 2

			if var_564_5 <= arg_561_1.time_ and arg_561_1.time_ < var_564_5 + var_564_6 then
				local var_564_7 = Color.New(0, 0, 0)

				var_564_7.a = Mathf.Lerp(0, 1, (arg_561_1.time_ - var_564_5) / var_564_6)
				arg_561_1.mask_.color = var_564_7
			end

			if arg_561_1.time_ >= var_564_5 + var_564_6 and arg_561_1.time_ < var_564_5 + var_564_6 + arg_564_0 then
				local var_564_8 = Color.New(0, 0, 0)

				var_564_8.a = 1
				arg_561_1.mask_.color = var_564_8
			end

			local var_564_9 = 2

			if 2 < arg_561_1.time_ and arg_561_1.time_ <= var_564_9 + arg_564_0 then
				arg_561_1.mask_.enabled = true
				arg_561_1.mask_.raycastTarget = true

				arg_561_1:SetGaussion(false)
			end

			local var_564_10 = 2

			if var_564_9 <= arg_561_1.time_ and arg_561_1.time_ < var_564_9 + var_564_10 then
				local var_564_11 = Color.New(0, 0, 0)

				var_564_11.a = Mathf.Lerp(1, 0, (arg_561_1.time_ - var_564_9) / var_564_10)
				arg_561_1.mask_.color = var_564_11
			end

			if arg_561_1.time_ >= var_564_9 + var_564_10 and arg_561_1.time_ < var_564_9 + var_564_10 + arg_564_0 then
				local var_564_12 = Color.New(0, 0, 0)

				arg_561_1.mask_.enabled = false
				var_564_12.a = 0
				arg_561_1.mask_.color = var_564_12
			end

			local var_564_13 = arg_561_1.actors_["1052ui_story"].transform

			if 2 < arg_561_1.time_ and arg_561_1.time_ <= 2 + arg_564_0 then
				arg_561_1.var_.moveOldPos1052ui_story = var_564_13.localPosition
			end

			local var_564_14 = 0.001

			if 2 <= arg_561_1.time_ and arg_561_1.time_ < 2 + var_564_14 then
				var_564_13.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1052ui_story, Vector3.New(0, 100, 0), (arg_561_1.time_ - 2) / var_564_14)
				var_564_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_564_13.position).x, (manager.ui.mainCamera.transform.position - var_564_13.position).y, (manager.ui.mainCamera.transform.position - var_564_13.position).z)
				var_564_13.localEulerAngles.z = 0
				var_564_13.localEulerAngles.x = 0
				var_564_13.localEulerAngles = var_564_13.localEulerAngles
			end

			if arg_561_1.time_ >= 2 + var_564_14 and arg_561_1.time_ < 2 + var_564_14 + arg_564_0 then
				var_564_13.localPosition = Vector3.New(0, 100, 0)
				var_564_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_564_13.position).x, (manager.ui.mainCamera.transform.position - var_564_13.position).y, (manager.ui.mainCamera.transform.position - var_564_13.position).z)
				var_564_13.localEulerAngles.z = 0
				var_564_13.localEulerAngles.x = 0
				var_564_13.localEulerAngles = var_564_13.localEulerAngles
			end

			local var_564_15 = arg_561_1.actors_["1052ui_story"]

			if 2 < arg_561_1.time_ and arg_561_1.time_ <= 2 + arg_564_0 and not isNil(var_564_15) and arg_561_1.var_.characterEffect1052ui_story == nil then
				arg_561_1.var_.characterEffect1052ui_story = var_564_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_16 = 0.034000001847744

			if 2 <= arg_561_1.time_ and arg_561_1.time_ < 2 + var_564_16 and not isNil(var_564_15) then
				if arg_561_1.var_.characterEffect1052ui_story and not isNil(var_564_15) then
					arg_561_1.var_.characterEffect1052ui_story.fillFlat = true
					arg_561_1.var_.characterEffect1052ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_561_1.time_ - 2) / var_564_16)
				end
			end

			if arg_561_1.time_ >= 2 + var_564_16 and arg_561_1.time_ < 2 + var_564_16 + arg_564_0 and not isNil(var_564_15) and arg_561_1.var_.characterEffect1052ui_story then
				arg_561_1.var_.characterEffect1052ui_story.fillFlat = true
				arg_561_1.var_.characterEffect1052ui_story.fillRatio = 0.5
			end

			if 0.233333333333333 < arg_561_1.time_ and arg_561_1.time_ <= 0.233333333333333 + arg_564_0 then
				arg_561_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if 1.6 < arg_561_1.time_ and arg_561_1.time_ <= 1.6 + arg_564_0 then
				arg_561_1:AudioAction("play", "effect", "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			if arg_561_1.frameCnt_ <= 1 then
				arg_561_1.dialog_:SetActive(false)
			end

			local var_564_19 = 4
			local var_564_20 = 0.25

			if 4 < arg_561_1.time_ and arg_561_1.time_ <= var_564_19 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0

				arg_561_1.dialog_:SetActive(true)

				arg_561_1.dialogCg_.alpha = 0

				local var_564_21 = LeanTween.value(arg_561_1.dialog_, 0, 1, 0.3)

				var_564_21:setOnUpdate(LuaHelper.FloatAction(function(arg_565_0)
					arg_561_1.dialogCg_.alpha = arg_565_0
				end))
				var_564_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_561_1.dialog_)
					var_564_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_561_1.duration_ = arg_561_1.duration_ + 0.3

				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_22 = arg_561_1:GetWordFromCfg(322151132)
				local var_564_23 = arg_561_1:FormatText(var_564_22.content)

				arg_561_1.text_.text = var_564_23

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_25 = 10 <= 0 and var_564_20 or var_564_20 * (utf8.len(var_564_23) / 10)

				if (10 <= 0 and var_564_20 or var_564_20 * (utf8.len(var_564_23) / 10)) > 0 and var_564_20 < var_564_25 then
					arg_561_1.talkMaxDuration = var_564_25
					var_564_19 = var_564_19 + 0.3

					if var_564_25 + var_564_19 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_25 + var_564_19
					end
				end

				arg_561_1.text_.text = var_564_23
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151132", "story_v_out_322151.awb") ~= 0 then
					local var_564_26 = manager.audio:GetVoiceLength("story_v_out_322151", "322151132", "story_v_out_322151.awb") / 1000

					if var_564_26 + var_564_19 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_26 + var_564_19
					end

					if var_564_22.prefab_name ~= "" and arg_561_1.actors_[var_564_22.prefab_name] ~= nil then
						local var_564_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_22.prefab_name].transform, "story_v_out_322151", "322151132", "story_v_out_322151.awb")

						arg_561_1:RecordAudio("322151132", var_564_27)
						arg_561_1:RecordAudio("322151132", var_564_27)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_322151", "322151132", "story_v_out_322151.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_322151", "322151132", "story_v_out_322151.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_28 = var_564_19 + 0.3
			local var_564_29 = math.max(var_564_20, arg_561_1.talkMaxDuration)

			if var_564_19 + 0.3 <= arg_561_1.time_ and arg_561_1.time_ < var_564_28 + var_564_29 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_28) / var_564_29

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_28 + var_564_29 and arg_561_1.time_ < var_564_28 + var_564_29 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1052ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play322151133 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 322151133
		arg_567_1.duration_ = 2.4

		local var_567_0 = {
			zh = 2.4,
			ja = 2.3
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play322151134(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			local var_570_0 = 0.25

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, true)
				arg_567_1.iconController_:SetSelectedState("hero")

				arg_567_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_567_1.callingController_:SetSelectedState("normal")

				arg_567_1.keyicon_.color = Color.New(1, 1, 1)
				arg_567_1.icon_.color = Color.New(1, 1, 1)

				local var_570_1 = arg_567_1:GetWordFromCfg(322151133)
				local var_570_2 = arg_567_1:FormatText(var_570_1.content)

				arg_567_1.text_.text = var_570_2

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_4 = 10 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_2) / 10)

				if (10 <= 0 and var_570_0 or var_570_0 * (utf8.len(var_570_2) / 10)) > 0 and var_570_0 < var_570_4 then
					arg_567_1.talkMaxDuration = var_570_4

					if var_570_4 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_4 + 0
					end
				end

				arg_567_1.text_.text = var_570_2
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151133", "story_v_out_322151.awb") ~= 0 then
					local var_570_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151133", "story_v_out_322151.awb") / 1000

					if var_570_5 + 0 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_5 + 0
					end

					if var_570_1.prefab_name ~= "" and arg_567_1.actors_[var_570_1.prefab_name] ~= nil then
						local var_570_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_1.prefab_name].transform, "story_v_out_322151", "322151133", "story_v_out_322151.awb")

						arg_567_1:RecordAudio("322151133", var_570_6)
						arg_567_1:RecordAudio("322151133", var_570_6)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_322151", "322151133", "story_v_out_322151.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_322151", "322151133", "story_v_out_322151.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_7 = math.max(var_570_0, arg_567_1.talkMaxDuration)

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_7 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - 0) / var_570_7

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= 0 + var_570_7 and arg_567_1.time_ < 0 + var_570_7 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {}

		arg_567_1:InitPlayNodeList()
	end,
	Play322151134 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 322151134
		arg_571_1.duration_ = 2.2

		local var_571_0 = {
			zh = 2.2,
			ja = 2.133
		}
		local var_571_1 = manager.audio:GetLocalizationFlag()

		if var_571_0[var_571_1] ~= nil then
			arg_571_1.duration_ = var_571_0[var_571_1]
		end

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play322151135(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			local var_574_0 = 0.225

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_1 = arg_571_1:GetWordFromCfg(322151134)
				local var_574_2 = arg_571_1:FormatText(var_574_1.content)

				arg_571_1.text_.text = var_574_2

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_4 = 9 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_2) / 9)

				if (9 <= 0 and var_574_0 or var_574_0 * (utf8.len(var_574_2) / 9)) > 0 and var_574_0 < var_574_4 then
					arg_571_1.talkMaxDuration = var_574_4

					if var_574_4 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_4 + 0
					end
				end

				arg_571_1.text_.text = var_574_2
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151134", "story_v_out_322151.awb") ~= 0 then
					local var_574_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151134", "story_v_out_322151.awb") / 1000

					if var_574_5 + 0 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_5 + 0
					end

					if var_574_1.prefab_name ~= "" and arg_571_1.actors_[var_574_1.prefab_name] ~= nil then
						local var_574_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_571_1.actors_[var_574_1.prefab_name].transform, "story_v_out_322151", "322151134", "story_v_out_322151.awb")

						arg_571_1:RecordAudio("322151134", var_574_6)
						arg_571_1:RecordAudio("322151134", var_574_6)
					else
						arg_571_1:AudioAction("play", "voice", "story_v_out_322151", "322151134", "story_v_out_322151.awb")
					end

					arg_571_1:RecordHistoryTalkVoice("story_v_out_322151", "322151134", "story_v_out_322151.awb")
				end

				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_0, arg_571_1.talkMaxDuration)

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - 0) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= 0 + var_574_7 and arg_571_1.time_ < 0 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play322151135 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 322151135
		arg_575_1.duration_ = 2.4

		local var_575_0 = {
			zh = 2.3,
			ja = 2.4
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play322151136(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			local var_578_0 = 0.15

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[1020].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, true)
				arg_575_1.iconController_:SetSelectedState("hero")

				arg_575_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_575_1.callingController_:SetSelectedState("normal")

				arg_575_1.keyicon_.color = Color.New(1, 1, 1)
				arg_575_1.icon_.color = Color.New(1, 1, 1)

				local var_578_1 = arg_575_1:GetWordFromCfg(322151135)
				local var_578_2 = arg_575_1:FormatText(var_578_1.content)

				arg_575_1.text_.text = var_578_2

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_4 = 6 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 6)

				if (6 <= 0 and var_578_0 or var_578_0 * (utf8.len(var_578_2) / 6)) > 0 and var_578_0 < var_578_4 then
					arg_575_1.talkMaxDuration = var_578_4

					if var_578_4 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_4 + 0
					end
				end

				arg_575_1.text_.text = var_578_2
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151135", "story_v_out_322151.awb") ~= 0 then
					local var_578_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151135", "story_v_out_322151.awb") / 1000

					if var_578_5 + 0 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_5 + 0
					end

					if var_578_1.prefab_name ~= "" and arg_575_1.actors_[var_578_1.prefab_name] ~= nil then
						local var_578_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_1.prefab_name].transform, "story_v_out_322151", "322151135", "story_v_out_322151.awb")

						arg_575_1:RecordAudio("322151135", var_578_6)
						arg_575_1:RecordAudio("322151135", var_578_6)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_322151", "322151135", "story_v_out_322151.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_322151", "322151135", "story_v_out_322151.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_7 = math.max(var_578_0, arg_575_1.talkMaxDuration)

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_7 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - 0) / var_578_7

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= 0 + var_578_7 and arg_575_1.time_ < 0 + var_578_7 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {}

		arg_575_1:InitPlayNodeList()
	end,
	Play322151136 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 322151136
		arg_579_1.duration_ = 8.07

		local var_579_0 = {
			zh = 5.865999999999,
			ja = 8.065999999999
		}
		local var_579_1 = manager.audio:GetLocalizationFlag()

		if var_579_0[var_579_1] ~= nil then
			arg_579_1.duration_ = var_579_0[var_579_1]
		end

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play322151137(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 2 < arg_579_1.time_ and arg_579_1.time_ <= 2 + arg_582_0 then
				local var_582_0 = arg_579_1.bgs_.MS2209a

				arg_579_1.bgs_.MS2209a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_582_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_582_1 = var_582_0:GetComponent("SpriteRenderer")

				if var_582_1 and var_582_1.sprite then
					local var_582_2 = 2 * (var_582_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_582_0.transform.localScale = Vector3.New(var_582_2 / var_582_1.sprite.bounds.size.y < var_582_2 * manager.ui.mainCameraCom_.aspect / var_582_1.sprite.bounds.size.x and var_582_2 * manager.ui.mainCameraCom_.aspect / var_582_1.sprite.bounds.size.x or var_582_2 / var_582_1.sprite.bounds.size.y, var_582_2 / var_582_1.sprite.bounds.size.y < var_582_2 * manager.ui.mainCameraCom_.aspect / var_582_1.sprite.bounds.size.x and var_582_2 * manager.ui.mainCameraCom_.aspect / var_582_1.sprite.bounds.size.x or var_582_2 / var_582_1.sprite.bounds.size.y, 0)
				end

				for iter_582_0, iter_582_1 in pairs(arg_579_1.bgs_) do
					if iter_582_0 ~= "MS2209a" then
						iter_582_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_582_3 = 4

			if 4 < arg_579_1.time_ and arg_579_1.time_ <= var_582_3 + arg_582_0 then
				arg_579_1.allBtn_.enabled = false
			end

			if arg_579_1.time_ >= var_582_3 + 0.3 and arg_579_1.time_ < var_582_3 + 0.3 + arg_582_0 then
				arg_579_1.allBtn_.enabled = true
			end

			local var_582_4 = 0

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_4 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_5 = 2

			if var_582_4 <= arg_579_1.time_ and arg_579_1.time_ < var_582_4 + var_582_5 then
				local var_582_6 = Color.New(0, 0, 0)

				var_582_6.a = Mathf.Lerp(0, 1, (arg_579_1.time_ - var_582_4) / var_582_5)
				arg_579_1.mask_.color = var_582_6
			end

			if arg_579_1.time_ >= var_582_4 + var_582_5 and arg_579_1.time_ < var_582_4 + var_582_5 + arg_582_0 then
				local var_582_7 = Color.New(0, 0, 0)

				var_582_7.a = 1
				arg_579_1.mask_.color = var_582_7
			end

			local var_582_8 = 2

			if 2 < arg_579_1.time_ and arg_579_1.time_ <= var_582_8 + arg_582_0 then
				arg_579_1.mask_.enabled = true
				arg_579_1.mask_.raycastTarget = true

				arg_579_1:SetGaussion(false)
			end

			local var_582_9 = 2

			if var_582_8 <= arg_579_1.time_ and arg_579_1.time_ < var_582_8 + var_582_9 then
				local var_582_10 = Color.New(0, 0, 0)

				var_582_10.a = Mathf.Lerp(1, 0, (arg_579_1.time_ - var_582_8) / var_582_9)
				arg_579_1.mask_.color = var_582_10
			end

			if arg_579_1.time_ >= var_582_8 + var_582_9 and arg_579_1.time_ < var_582_8 + var_582_9 + arg_582_0 then
				local var_582_11 = Color.New(0, 0, 0)

				arg_579_1.mask_.enabled = false
				var_582_11.a = 0
				arg_579_1.mask_.color = var_582_11
			end

			if 0.1 < arg_579_1.time_ and arg_579_1.time_ <= 0.1 + arg_582_0 then
				arg_579_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_boxing_amb_cheer06_loop", "")
			end

			if 1.6 < arg_579_1.time_ and arg_579_1.time_ <= 1.6 + arg_582_0 then
				arg_579_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_gold_rain", "")
			end

			if arg_579_1.frameCnt_ <= 1 then
				arg_579_1.dialog_:SetActive(false)
			end

			local var_582_14 = 3.999999999999
			local var_582_15 = 0.3

			if 3.999999999999 < arg_579_1.time_ and arg_579_1.time_ <= var_582_14 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0

				arg_579_1.dialog_:SetActive(true)

				arg_579_1.dialogCg_.alpha = 0

				local var_582_16 = LeanTween.value(arg_579_1.dialog_, 0, 1, 0.3)

				var_582_16:setOnUpdate(LuaHelper.FloatAction(function(arg_583_0)
					arg_579_1.dialogCg_.alpha = arg_583_0
				end))
				var_582_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_579_1.dialog_)
					var_582_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_579_1.duration_ = arg_579_1.duration_ + 0.3

				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, false)
				arg_579_1.callingController_:SetSelectedState("normal")

				local var_582_17 = arg_579_1:GetWordFromCfg(322151136)
				local var_582_18 = arg_579_1:FormatText(var_582_17.content)

				arg_579_1.text_.text = var_582_18

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_20 = 12 <= 0 and var_582_15 or var_582_15 * (utf8.len(var_582_18) / 12)

				if (12 <= 0 and var_582_15 or var_582_15 * (utf8.len(var_582_18) / 12)) > 0 and var_582_15 < var_582_20 then
					arg_579_1.talkMaxDuration = var_582_20
					var_582_14 = var_582_14 + 0.3

					if var_582_20 + var_582_14 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_20 + var_582_14
					end
				end

				arg_579_1.text_.text = var_582_18
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151136", "story_v_out_322151.awb") ~= 0 then
					local var_582_21 = manager.audio:GetVoiceLength("story_v_out_322151", "322151136", "story_v_out_322151.awb") / 1000

					if var_582_21 + var_582_14 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_21 + var_582_14
					end

					if var_582_17.prefab_name ~= "" and arg_579_1.actors_[var_582_17.prefab_name] ~= nil then
						local var_582_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_579_1.actors_[var_582_17.prefab_name].transform, "story_v_out_322151", "322151136", "story_v_out_322151.awb")

						arg_579_1:RecordAudio("322151136", var_582_22)
						arg_579_1:RecordAudio("322151136", var_582_22)
					else
						arg_579_1:AudioAction("play", "voice", "story_v_out_322151", "322151136", "story_v_out_322151.awb")
					end

					arg_579_1:RecordHistoryTalkVoice("story_v_out_322151", "322151136", "story_v_out_322151.awb")
				end

				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_23 = var_582_14 + 0.3
			local var_582_24 = math.max(var_582_15, arg_579_1.talkMaxDuration)

			if var_582_14 + 0.3 <= arg_579_1.time_ and arg_579_1.time_ < var_582_23 + var_582_24 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_23) / var_582_24

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_23 + var_582_24 and arg_579_1.time_ < var_582_23 + var_582_24 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play322151137 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 322151137
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play322151138(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0.175

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_1 = arg_585_1:FormatText(arg_585_1:GetWordFromCfg(322151137).content)

				arg_585_1.text_.text = var_588_1

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_3 = 7 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 7)

				if (7 <= 0 and var_588_0 or var_588_0 * (utf8.len(var_588_1) / 7)) > 0 and var_588_0 < var_588_3 then
					arg_585_1.talkMaxDuration = var_588_3

					if var_588_3 + 0 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_3 + 0
					end
				end

				arg_585_1.text_.text = var_588_1
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_4 = math.max(var_588_0, arg_585_1.talkMaxDuration)

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - 0) / var_588_4

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play322151138 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 322151138
		arg_589_1.duration_ = 4.93

		local var_589_0 = {
			zh = 3.633,
			ja = 4.933
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play322151139(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = 0.45

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_1 = arg_589_1:GetWordFromCfg(322151138)
				local var_592_2 = arg_589_1:FormatText(var_592_1.content)

				arg_589_1.text_.text = var_592_2

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_4 = 18 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_2) / 18)

				if (18 <= 0 and var_592_0 or var_592_0 * (utf8.len(var_592_2) / 18)) > 0 and var_592_0 < var_592_4 then
					arg_589_1.talkMaxDuration = var_592_4

					if var_592_4 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_4 + 0
					end
				end

				arg_589_1.text_.text = var_592_2
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151138", "story_v_out_322151.awb") ~= 0 then
					local var_592_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151138", "story_v_out_322151.awb") / 1000

					if var_592_5 + 0 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_5 + 0
					end

					if var_592_1.prefab_name ~= "" and arg_589_1.actors_[var_592_1.prefab_name] ~= nil then
						local var_592_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_1.prefab_name].transform, "story_v_out_322151", "322151138", "story_v_out_322151.awb")

						arg_589_1:RecordAudio("322151138", var_592_6)
						arg_589_1:RecordAudio("322151138", var_592_6)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_322151", "322151138", "story_v_out_322151.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_322151", "322151138", "story_v_out_322151.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_7 = math.max(var_592_0, arg_589_1.talkMaxDuration)

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_7 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - 0) / var_592_7

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= 0 + var_592_7 and arg_589_1.time_ < 0 + var_592_7 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {}

		arg_589_1:InitPlayNodeList()
	end,
	Play322151139 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 322151139
		arg_593_1.duration_ = 4.4

		local var_593_0 = {
			zh = 3.833,
			ja = 4.4
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play322151140(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0.4

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_1 = arg_593_1:GetWordFromCfg(322151139)
				local var_596_2 = arg_593_1:FormatText(var_596_1.content)

				arg_593_1.text_.text = var_596_2

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_4 = 16 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 16)

				if (16 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 16)) > 0 and var_596_0 < var_596_4 then
					arg_593_1.talkMaxDuration = var_596_4

					if var_596_4 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_4 + 0
					end
				end

				arg_593_1.text_.text = var_596_2
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151139", "story_v_out_322151.awb") ~= 0 then
					local var_596_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151139", "story_v_out_322151.awb") / 1000

					if var_596_5 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_5 + 0
					end

					if var_596_1.prefab_name ~= "" and arg_593_1.actors_[var_596_1.prefab_name] ~= nil then
						local var_596_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_1.prefab_name].transform, "story_v_out_322151", "322151139", "story_v_out_322151.awb")

						arg_593_1:RecordAudio("322151139", var_596_6)
						arg_593_1:RecordAudio("322151139", var_596_6)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_322151", "322151139", "story_v_out_322151.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_322151", "322151139", "story_v_out_322151.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_7 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_7 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_7

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_7 and arg_593_1.time_ < 0 + var_596_7 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play322151140 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 322151140
		arg_597_1.duration_ = 5

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play322151141(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0.55

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_1 = arg_597_1:FormatText(arg_597_1:GetWordFromCfg(322151140).content)

				arg_597_1.text_.text = var_600_1

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_3 = 22 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_1) / 22)

				if (22 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_1) / 22)) > 0 and var_600_0 < var_600_3 then
					arg_597_1.talkMaxDuration = var_600_3

					if var_600_3 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_3 + 0
					end
				end

				arg_597_1.text_.text = var_600_1
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)
				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_4 = math.max(var_600_0, arg_597_1.talkMaxDuration)

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_4 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - 0) / var_600_4

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= 0 + var_600_4 and arg_597_1.time_ < 0 + var_600_4 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play322151141 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 322151141
		arg_601_1.duration_ = 9.87

		local var_601_0 = {
			zh = 6.3,
			ja = 9.866
		}
		local var_601_1 = manager.audio:GetLocalizationFlag()

		if var_601_0[var_601_1] ~= nil then
			arg_601_1.duration_ = var_601_0[var_601_1]
		end

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play322151142(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0.725

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, true)

				arg_601_1.leftNameTxt_.text = arg_601_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_601_1.leftNameTxt_.transform)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1.leftNameTxt_.text)
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_1 = arg_601_1:GetWordFromCfg(322151141)
				local var_604_2 = arg_601_1:FormatText(var_604_1.content)

				arg_601_1.text_.text = var_604_2

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_4 = 29 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_2) / 29)

				if (29 <= 0 and var_604_0 or var_604_0 * (utf8.len(var_604_2) / 29)) > 0 and var_604_0 < var_604_4 then
					arg_601_1.talkMaxDuration = var_604_4

					if var_604_4 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_4 + 0
					end
				end

				arg_601_1.text_.text = var_604_2
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151141", "story_v_out_322151.awb") ~= 0 then
					local var_604_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151141", "story_v_out_322151.awb") / 1000

					if var_604_5 + 0 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_5 + 0
					end

					if var_604_1.prefab_name ~= "" and arg_601_1.actors_[var_604_1.prefab_name] ~= nil then
						local var_604_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_601_1.actors_[var_604_1.prefab_name].transform, "story_v_out_322151", "322151141", "story_v_out_322151.awb")

						arg_601_1:RecordAudio("322151141", var_604_6)
						arg_601_1:RecordAudio("322151141", var_604_6)
					else
						arg_601_1:AudioAction("play", "voice", "story_v_out_322151", "322151141", "story_v_out_322151.awb")
					end

					arg_601_1:RecordHistoryTalkVoice("story_v_out_322151", "322151141", "story_v_out_322151.awb")
				end

				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_7 = math.max(var_604_0, arg_601_1.talkMaxDuration)

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_7 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - 0) / var_604_7

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= 0 + var_604_7 and arg_601_1.time_ < 0 + var_604_7 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play322151142 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 322151142
		arg_605_1.duration_ = 5

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play322151143(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			local var_608_0 = 0.6

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_1 = arg_605_1:FormatText(arg_605_1:GetWordFromCfg(322151142).content)

				arg_605_1.text_.text = var_608_1

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_3 = 24 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 24)

				if (24 <= 0 and var_608_0 or var_608_0 * (utf8.len(var_608_1) / 24)) > 0 and var_608_0 < var_608_3 then
					arg_605_1.talkMaxDuration = var_608_3

					if var_608_3 + 0 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_3 + 0
					end
				end

				arg_605_1.text_.text = var_608_1
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)
				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_4 = math.max(var_608_0, arg_605_1.talkMaxDuration)

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_4 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - 0) / var_608_4

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= 0 + var_608_4 and arg_605_1.time_ < 0 + var_608_4 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play322151143 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 322151143
		arg_609_1.duration_ = 5

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play322151144(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			local var_612_0 = 1.575

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= 0 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0
				arg_609_1.dialogCg_.alpha = 1

				arg_609_1.dialog_:SetActive(true)
				SetActive(arg_609_1.leftNameGo_, true)

				arg_609_1.leftNameTxt_.text = arg_609_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_609_1.leftNameTxt_.transform)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1.leftNameTxt_.text)
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_1 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(322151143).content)

				arg_609_1.text_.text = var_612_1

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_3 = 63 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 63)

				if (63 <= 0 and var_612_0 or var_612_0 * (utf8.len(var_612_1) / 63)) > 0 and var_612_0 < var_612_3 then
					arg_609_1.talkMaxDuration = var_612_3

					if var_612_3 + 0 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_3 + 0
					end
				end

				arg_609_1.text_.text = var_612_1
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_4 = math.max(var_612_0, arg_609_1.talkMaxDuration)

			if 0 <= arg_609_1.time_ and arg_609_1.time_ < 0 + var_612_4 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - 0) / var_612_4

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= 0 + var_612_4 and arg_609_1.time_ < 0 + var_612_4 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {}

		arg_609_1:InitPlayNodeList()
	end,
	Play322151144 = function(arg_613_0, arg_613_1)
		arg_613_1.time_ = 0
		arg_613_1.frameCnt_ = 0
		arg_613_1.state_ = "playing"
		arg_613_1.curTalkId_ = 322151144
		arg_613_1.duration_ = 1.57

		local var_613_0 = {
			zh = 0.999999999999,
			ja = 1.566
		}
		local var_613_1 = manager.audio:GetLocalizationFlag()

		if var_613_0[var_613_1] ~= nil then
			arg_613_1.duration_ = var_613_0[var_613_1]
		end

		SetActive(arg_613_1.tipsGo_, false)

		function arg_613_1.onSingleLineFinish_()
			arg_613_1.onSingleLineUpdate_ = nil
			arg_613_1.onSingleLineFinish_ = nil
			arg_613_1.state_ = "waiting"
		end

		function arg_613_1.playNext_(arg_615_0)
			if arg_615_0 == 1 then
				arg_613_0:Play322151145(arg_613_1)
			end
		end

		function arg_613_1.onSingleLineUpdate_(arg_616_0)
			local var_616_0 = 0.075

			if 0 < arg_613_1.time_ and arg_613_1.time_ <= 0 + arg_616_0 then
				arg_613_1.talkMaxDuration = 0
				arg_613_1.dialogCg_.alpha = 1

				arg_613_1.dialog_:SetActive(true)
				SetActive(arg_613_1.leftNameGo_, true)

				arg_613_1.leftNameTxt_.text = arg_613_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_613_1.leftNameTxt_.transform)

				arg_613_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_613_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_613_1:RecordName(arg_613_1.leftNameTxt_.text)
				SetActive(arg_613_1.iconTrs_.gameObject, false)
				arg_613_1.callingController_:SetSelectedState("normal")

				local var_616_1 = arg_613_1:GetWordFromCfg(322151144)
				local var_616_2 = arg_613_1:FormatText(var_616_1.content)

				arg_613_1.text_.text = var_616_2

				LuaForUtil.ClearLinePrefixSymbol(arg_613_1.text_)

				local var_616_4 = 3 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_2) / 3)

				if (3 <= 0 and var_616_0 or var_616_0 * (utf8.len(var_616_2) / 3)) > 0 and var_616_0 < var_616_4 then
					arg_613_1.talkMaxDuration = var_616_4

					if var_616_4 + 0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_4 + 0
					end
				end

				arg_613_1.text_.text = var_616_2
				arg_613_1.typewritter.percent = 0

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151144", "story_v_out_322151.awb") ~= 0 then
					local var_616_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151144", "story_v_out_322151.awb") / 1000

					if var_616_5 + 0 > arg_613_1.duration_ then
						arg_613_1.duration_ = var_616_5 + 0
					end

					if var_616_1.prefab_name ~= "" and arg_613_1.actors_[var_616_1.prefab_name] ~= nil then
						local var_616_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_613_1.actors_[var_616_1.prefab_name].transform, "story_v_out_322151", "322151144", "story_v_out_322151.awb")

						arg_613_1:RecordAudio("322151144", var_616_6)
						arg_613_1:RecordAudio("322151144", var_616_6)
					else
						arg_613_1:AudioAction("play", "voice", "story_v_out_322151", "322151144", "story_v_out_322151.awb")
					end

					arg_613_1:RecordHistoryTalkVoice("story_v_out_322151", "322151144", "story_v_out_322151.awb")
				end

				arg_613_1:RecordContent(arg_613_1.text_.text)
			end

			local var_616_7 = math.max(var_616_0, arg_613_1.talkMaxDuration)

			if 0 <= arg_613_1.time_ and arg_613_1.time_ < 0 + var_616_7 then
				arg_613_1.typewritter.percent = (arg_613_1.time_ - 0) / var_616_7

				arg_613_1.typewritter:SetDirty()
			end

			if arg_613_1.time_ >= 0 + var_616_7 and arg_613_1.time_ < 0 + var_616_7 + arg_616_0 then
				arg_613_1.typewritter.percent = 1

				arg_613_1.typewritter:SetDirty()
				arg_613_1:ShowNextGo(true)
			end
		end

		arg_613_1.nodeConfigList_ = {}

		arg_613_1:InitPlayNodeList()
	end,
	Play322151145 = function(arg_617_0, arg_617_1)
		arg_617_1.time_ = 0
		arg_617_1.frameCnt_ = 0
		arg_617_1.state_ = "playing"
		arg_617_1.curTalkId_ = 322151145
		arg_617_1.duration_ = 5

		SetActive(arg_617_1.tipsGo_, false)

		function arg_617_1.onSingleLineFinish_()
			arg_617_1.onSingleLineUpdate_ = nil
			arg_617_1.onSingleLineFinish_ = nil
			arg_617_1.state_ = "waiting"
		end

		function arg_617_1.playNext_(arg_619_0)
			if arg_619_0 == 1 then
				arg_617_0:Play322151146(arg_617_1)
			end
		end

		function arg_617_1.onSingleLineUpdate_(arg_620_0)
			local var_620_0 = 0.125

			if 0 < arg_617_1.time_ and arg_617_1.time_ <= 0 + arg_620_0 then
				arg_617_1.talkMaxDuration = 0
				arg_617_1.dialogCg_.alpha = 1

				arg_617_1.dialog_:SetActive(true)
				SetActive(arg_617_1.leftNameGo_, true)

				arg_617_1.leftNameTxt_.text = arg_617_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_617_1.leftNameTxt_.transform)

				arg_617_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_617_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_617_1:RecordName(arg_617_1.leftNameTxt_.text)
				SetActive(arg_617_1.iconTrs_.gameObject, false)
				arg_617_1.callingController_:SetSelectedState("normal")

				local var_620_1 = arg_617_1:FormatText(arg_617_1:GetWordFromCfg(322151145).content)

				arg_617_1.text_.text = var_620_1

				LuaForUtil.ClearLinePrefixSymbol(arg_617_1.text_)

				local var_620_3 = 5 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_1) / 5)

				if (5 <= 0 and var_620_0 or var_620_0 * (utf8.len(var_620_1) / 5)) > 0 and var_620_0 < var_620_3 then
					arg_617_1.talkMaxDuration = var_620_3

					if var_620_3 + 0 > arg_617_1.duration_ then
						arg_617_1.duration_ = var_620_3 + 0
					end
				end

				arg_617_1.text_.text = var_620_1
				arg_617_1.typewritter.percent = 0

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(false)
				arg_617_1:RecordContent(arg_617_1.text_.text)
			end

			local var_620_4 = math.max(var_620_0, arg_617_1.talkMaxDuration)

			if 0 <= arg_617_1.time_ and arg_617_1.time_ < 0 + var_620_4 then
				arg_617_1.typewritter.percent = (arg_617_1.time_ - 0) / var_620_4

				arg_617_1.typewritter:SetDirty()
			end

			if arg_617_1.time_ >= 0 + var_620_4 and arg_617_1.time_ < 0 + var_620_4 + arg_620_0 then
				arg_617_1.typewritter.percent = 1

				arg_617_1.typewritter:SetDirty()
				arg_617_1:ShowNextGo(true)
			end
		end

		arg_617_1.nodeConfigList_ = {}

		arg_617_1:InitPlayNodeList()
	end,
	Play322151146 = function(arg_621_0, arg_621_1)
		arg_621_1.time_ = 0
		arg_621_1.frameCnt_ = 0
		arg_621_1.state_ = "playing"
		arg_621_1.curTalkId_ = 322151146
		arg_621_1.duration_ = 5.83

		local var_621_0 = {
			zh = 4.9,
			ja = 5.833
		}
		local var_621_1 = manager.audio:GetLocalizationFlag()

		if var_621_0[var_621_1] ~= nil then
			arg_621_1.duration_ = var_621_0[var_621_1]
		end

		SetActive(arg_621_1.tipsGo_, false)

		function arg_621_1.onSingleLineFinish_()
			arg_621_1.onSingleLineUpdate_ = nil
			arg_621_1.onSingleLineFinish_ = nil
			arg_621_1.state_ = "waiting"
		end

		function arg_621_1.playNext_(arg_623_0)
			if arg_623_0 == 1 then
				arg_621_0:Play322151147(arg_621_1)
			end
		end

		function arg_621_1.onSingleLineUpdate_(arg_624_0)
			local var_624_0 = 0.625

			if 0 < arg_621_1.time_ and arg_621_1.time_ <= 0 + arg_624_0 then
				arg_621_1.talkMaxDuration = 0
				arg_621_1.dialogCg_.alpha = 1

				arg_621_1.dialog_:SetActive(true)
				SetActive(arg_621_1.leftNameGo_, true)

				arg_621_1.leftNameTxt_.text = arg_621_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_621_1.leftNameTxt_.transform)

				arg_621_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_621_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_621_1:RecordName(arg_621_1.leftNameTxt_.text)
				SetActive(arg_621_1.iconTrs_.gameObject, false)
				arg_621_1.callingController_:SetSelectedState("normal")

				local var_624_1 = arg_621_1:GetWordFromCfg(322151146)
				local var_624_2 = arg_621_1:FormatText(var_624_1.content)

				arg_621_1.text_.text = var_624_2

				LuaForUtil.ClearLinePrefixSymbol(arg_621_1.text_)

				local var_624_4 = 25 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 25)

				if (25 <= 0 and var_624_0 or var_624_0 * (utf8.len(var_624_2) / 25)) > 0 and var_624_0 < var_624_4 then
					arg_621_1.talkMaxDuration = var_624_4

					if var_624_4 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_4 + 0
					end
				end

				arg_621_1.text_.text = var_624_2
				arg_621_1.typewritter.percent = 0

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151146", "story_v_out_322151.awb") ~= 0 then
					local var_624_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151146", "story_v_out_322151.awb") / 1000

					if var_624_5 + 0 > arg_621_1.duration_ then
						arg_621_1.duration_ = var_624_5 + 0
					end

					if var_624_1.prefab_name ~= "" and arg_621_1.actors_[var_624_1.prefab_name] ~= nil then
						local var_624_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_621_1.actors_[var_624_1.prefab_name].transform, "story_v_out_322151", "322151146", "story_v_out_322151.awb")

						arg_621_1:RecordAudio("322151146", var_624_6)
						arg_621_1:RecordAudio("322151146", var_624_6)
					else
						arg_621_1:AudioAction("play", "voice", "story_v_out_322151", "322151146", "story_v_out_322151.awb")
					end

					arg_621_1:RecordHistoryTalkVoice("story_v_out_322151", "322151146", "story_v_out_322151.awb")
				end

				arg_621_1:RecordContent(arg_621_1.text_.text)
			end

			local var_624_7 = math.max(var_624_0, arg_621_1.talkMaxDuration)

			if 0 <= arg_621_1.time_ and arg_621_1.time_ < 0 + var_624_7 then
				arg_621_1.typewritter.percent = (arg_621_1.time_ - 0) / var_624_7

				arg_621_1.typewritter:SetDirty()
			end

			if arg_621_1.time_ >= 0 + var_624_7 and arg_621_1.time_ < 0 + var_624_7 + arg_624_0 then
				arg_621_1.typewritter.percent = 1

				arg_621_1.typewritter:SetDirty()
				arg_621_1:ShowNextGo(true)
			end
		end

		arg_621_1.nodeConfigList_ = {}

		arg_621_1:InitPlayNodeList()
	end,
	Play322151147 = function(arg_625_0, arg_625_1)
		arg_625_1.time_ = 0
		arg_625_1.frameCnt_ = 0
		arg_625_1.state_ = "playing"
		arg_625_1.curTalkId_ = 322151147
		arg_625_1.duration_ = 5

		SetActive(arg_625_1.tipsGo_, false)

		function arg_625_1.onSingleLineFinish_()
			arg_625_1.onSingleLineUpdate_ = nil
			arg_625_1.onSingleLineFinish_ = nil
			arg_625_1.state_ = "waiting"
		end

		function arg_625_1.playNext_(arg_627_0)
			if arg_627_0 == 1 then
				arg_625_0:Play322151148(arg_625_1)
			end
		end

		function arg_625_1.onSingleLineUpdate_(arg_628_0)
			local var_628_0 = 0.575

			if 0 < arg_625_1.time_ and arg_625_1.time_ <= 0 + arg_628_0 then
				arg_625_1.talkMaxDuration = 0
				arg_625_1.dialogCg_.alpha = 1

				arg_625_1.dialog_:SetActive(true)
				SetActive(arg_625_1.leftNameGo_, true)

				arg_625_1.leftNameTxt_.text = arg_625_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_625_1.leftNameTxt_.transform)

				arg_625_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_625_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_625_1:RecordName(arg_625_1.leftNameTxt_.text)
				SetActive(arg_625_1.iconTrs_.gameObject, false)
				arg_625_1.callingController_:SetSelectedState("normal")

				local var_628_1 = arg_625_1:FormatText(arg_625_1:GetWordFromCfg(322151147).content)

				arg_625_1.text_.text = var_628_1

				LuaForUtil.ClearLinePrefixSymbol(arg_625_1.text_)

				local var_628_3 = 23 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 23)

				if (23 <= 0 and var_628_0 or var_628_0 * (utf8.len(var_628_1) / 23)) > 0 and var_628_0 < var_628_3 then
					arg_625_1.talkMaxDuration = var_628_3

					if var_628_3 + 0 > arg_625_1.duration_ then
						arg_625_1.duration_ = var_628_3 + 0
					end
				end

				arg_625_1.text_.text = var_628_1
				arg_625_1.typewritter.percent = 0

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(false)
				arg_625_1:RecordContent(arg_625_1.text_.text)
			end

			local var_628_4 = math.max(var_628_0, arg_625_1.talkMaxDuration)

			if 0 <= arg_625_1.time_ and arg_625_1.time_ < 0 + var_628_4 then
				arg_625_1.typewritter.percent = (arg_625_1.time_ - 0) / var_628_4

				arg_625_1.typewritter:SetDirty()
			end

			if arg_625_1.time_ >= 0 + var_628_4 and arg_625_1.time_ < 0 + var_628_4 + arg_628_0 then
				arg_625_1.typewritter.percent = 1

				arg_625_1.typewritter:SetDirty()
				arg_625_1:ShowNextGo(true)
			end
		end

		arg_625_1.nodeConfigList_ = {}

		arg_625_1:InitPlayNodeList()
	end,
	Play322151148 = function(arg_629_0, arg_629_1)
		arg_629_1.time_ = 0
		arg_629_1.frameCnt_ = 0
		arg_629_1.state_ = "playing"
		arg_629_1.curTalkId_ = 322151148
		arg_629_1.duration_ = 7

		SetActive(arg_629_1.tipsGo_, false)

		function arg_629_1.onSingleLineFinish_()
			arg_629_1.onSingleLineUpdate_ = nil
			arg_629_1.onSingleLineFinish_ = nil
			arg_629_1.state_ = "waiting"
		end

		function arg_629_1.playNext_(arg_631_0)
			if arg_631_0 == 1 then
				arg_629_0:Play322151149(arg_629_1)
			end
		end

		function arg_629_1.onSingleLineUpdate_(arg_632_0)
			local var_632_9000

			if 1 < arg_629_1.time_ and arg_629_1.time_ <= 1 + arg_632_0 then
				local var_632_0 = arg_629_1.bgs_.MS2209

				arg_629_1.bgs_.MS2209.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_632_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_632_1 = var_632_0:GetComponent("SpriteRenderer")

				if var_632_1 and var_632_1.sprite then
					local var_632_2 = 2 * (var_632_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_632_0.transform.localScale = Vector3.New(var_632_2 / var_632_1.sprite.bounds.size.y < var_632_2 * manager.ui.mainCameraCom_.aspect / var_632_1.sprite.bounds.size.x and var_632_2 * manager.ui.mainCameraCom_.aspect / var_632_1.sprite.bounds.size.x or var_632_2 / var_632_1.sprite.bounds.size.y, var_632_2 / var_632_1.sprite.bounds.size.y < var_632_2 * manager.ui.mainCameraCom_.aspect / var_632_1.sprite.bounds.size.x and var_632_2 * manager.ui.mainCameraCom_.aspect / var_632_1.sprite.bounds.size.x or var_632_2 / var_632_1.sprite.bounds.size.y, 0)
				end

				for iter_632_0, iter_632_1 in pairs(arg_629_1.bgs_) do
					if iter_632_0 ~= "MS2209" then
						iter_632_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_632_3 = 2

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= var_632_3 + arg_632_0 then
				arg_629_1.allBtn_.enabled = false
			end

			if arg_629_1.time_ >= var_632_3 + 0.3 and arg_629_1.time_ < var_632_3 + 0.3 + arg_632_0 then
				arg_629_1.allBtn_.enabled = true
			end

			local var_632_4 = 0

			if 0 < arg_629_1.time_ and arg_629_1.time_ <= var_632_4 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_5 = 1

			if var_632_4 <= arg_629_1.time_ and arg_629_1.time_ < var_632_4 + var_632_5 then
				local var_632_6 = Color.New(0, 0, 0)

				var_632_6.a = Mathf.Lerp(0, 1, (arg_629_1.time_ - var_632_4) / var_632_5)
				arg_629_1.mask_.color = var_632_6
			end

			if arg_629_1.time_ >= var_632_4 + var_632_5 and arg_629_1.time_ < var_632_4 + var_632_5 + arg_632_0 then
				local var_632_7 = Color.New(0, 0, 0)

				var_632_7.a = 1
				arg_629_1.mask_.color = var_632_7
			end

			local var_632_8 = 1

			if 1 < arg_629_1.time_ and arg_629_1.time_ <= var_632_8 + arg_632_0 then
				arg_629_1.mask_.enabled = true
				arg_629_1.mask_.raycastTarget = true

				arg_629_1:SetGaussion(false)
			end

			local var_632_9 = 1

			if var_632_8 <= arg_629_1.time_ and arg_629_1.time_ < var_632_8 + var_632_9 then
				local var_632_10 = Color.New(0, 0, 0)

				var_632_10.a = Mathf.Lerp(1, 0, (arg_629_1.time_ - var_632_8) / var_632_9)
				arg_629_1.mask_.color = var_632_10
			end

			if arg_629_1.time_ >= var_632_8 + var_632_9 and arg_629_1.time_ < var_632_8 + var_632_9 + arg_632_0 then
				local var_632_11 = Color.New(0, 0, 0)

				arg_629_1.mask_.enabled = false
				var_632_11.a = 0
				arg_629_1.mask_.color = var_632_11
			end

			if 1 < arg_629_1.time_ and arg_629_1.time_ <= 1 + arg_632_0 then
				arg_629_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_gold_rain", "")
			end

			if 1.1 < arg_629_1.time_ and arg_629_1.time_ <= 1.1 + arg_632_0 then
				arg_629_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 1 < arg_629_1.time_ and arg_629_1.time_ <= 1 + arg_632_0 then
				local var_632_14 = arg_629_1.var_.effect1148

				if not arg_629_1.var_.effect1148 then
					var_632_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_632_14.name = "1148"
					arg_629_1.var_.effect1148 = var_632_14
				else
					var_632_14.transform:SetParent(var_632_9000)
				end

				var_632_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_632_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_629_1.frameCnt_ <= 1 then
				arg_629_1.dialog_:SetActive(false)
			end

			local var_632_16 = 2
			local var_632_17 = 0.825

			if 2 < arg_629_1.time_ and arg_629_1.time_ <= var_632_16 + arg_632_0 then
				arg_629_1.talkMaxDuration = 0

				arg_629_1.dialog_:SetActive(true)

				arg_629_1.dialogCg_.alpha = 0

				local var_632_18 = LeanTween.value(arg_629_1.dialog_, 0, 1, 0.3)

				var_632_18:setOnUpdate(LuaHelper.FloatAction(function(arg_633_0)
					arg_629_1.dialogCg_.alpha = arg_633_0
				end))
				var_632_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_629_1.dialog_)
					var_632_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_629_1.duration_ = arg_629_1.duration_ + 0.3

				SetActive(arg_629_1.leftNameGo_, false)

				arg_629_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_629_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_629_1:RecordName(arg_629_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_629_1.iconTrs_.gameObject, false)
				arg_629_1.callingController_:SetSelectedState("normal")

				local var_632_19 = arg_629_1:FormatText(arg_629_1:GetWordFromCfg(322151148).content)

				arg_629_1.text_.text = var_632_19

				LuaForUtil.ClearLinePrefixSymbol(arg_629_1.text_)

				local var_632_21 = 33 <= 0 and var_632_17 or var_632_17 * (utf8.len(var_632_19) / 33)

				if (33 <= 0 and var_632_17 or var_632_17 * (utf8.len(var_632_19) / 33)) > 0 and var_632_17 < var_632_21 then
					arg_629_1.talkMaxDuration = var_632_21
					var_632_16 = var_632_16 + 0.3

					if var_632_21 + var_632_16 > arg_629_1.duration_ then
						arg_629_1.duration_ = var_632_21 + var_632_16
					end
				end

				arg_629_1.text_.text = var_632_19
				arg_629_1.typewritter.percent = 0

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(false)
				arg_629_1:RecordContent(arg_629_1.text_.text)
			end

			local var_632_22 = var_632_16 + 0.3
			local var_632_23 = math.max(var_632_17, arg_629_1.talkMaxDuration)

			if var_632_16 + 0.3 <= arg_629_1.time_ and arg_629_1.time_ < var_632_22 + var_632_23 then
				arg_629_1.typewritter.percent = (arg_629_1.time_ - var_632_22) / var_632_23

				arg_629_1.typewritter:SetDirty()
			end

			if arg_629_1.time_ >= var_632_22 + var_632_23 and arg_629_1.time_ < var_632_22 + var_632_23 + arg_632_0 then
				arg_629_1.typewritter.percent = 1

				arg_629_1.typewritter:SetDirty()
				arg_629_1:ShowNextGo(true)
			end
		end

		arg_629_1.nodeConfigList_ = {}

		arg_629_1:InitPlayNodeList()
	end,
	Play322151149 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 322151149
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play322151150(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 1.225

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, false)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_1 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(322151149).content)

				arg_635_1.text_.text = var_638_1

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_3 = 49 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_1) / 49)

				if (49 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_1) / 49)) > 0 and var_638_0 < var_638_3 then
					arg_635_1.talkMaxDuration = var_638_3

					if var_638_3 + 0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_3 + 0
					end
				end

				arg_635_1.text_.text = var_638_1
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_4 = math.max(var_638_0, arg_635_1.talkMaxDuration)

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_4 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - 0) / var_638_4

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= 0 + var_638_4 and arg_635_1.time_ < 0 + var_638_4 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play322151150 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 322151150
		arg_639_1.duration_ = 6.33

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play322151151(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.var_.moveOldPosMS2209 = arg_639_1.bgs_.MS2209.transform.localPosition
			end

			local var_642_0 = 0.001

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 then
				arg_639_1.bgs_.MS2209.transform.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPosMS2209, Vector3.New(0, 2, 5), (arg_639_1.time_ - 0) / var_642_0)
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 then
				arg_639_1.bgs_.MS2209.transform.localPosition = Vector3.New(0, 2, 5)
			end

			local var_642_1 = arg_639_1.bgs_.MS2209.transform

			if 0.034 < arg_639_1.time_ and arg_639_1.time_ <= 0.034 + arg_642_0 then
				arg_639_1.var_.moveOldPosMS2209 = var_642_1.localPosition
			end

			local var_642_2 = 1.29933333333333

			if 0.034 <= arg_639_1.time_ and arg_639_1.time_ < 0.034 + var_642_2 then
				var_642_1.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPosMS2209, Vector3.New(0, 2, 4.5), (arg_639_1.time_ - 0.034) / var_642_2)
			end

			if arg_639_1.time_ >= 0.034 + var_642_2 and arg_639_1.time_ < 0.034 + var_642_2 + arg_642_0 then
				var_642_1.localPosition = Vector3.New(0, 2, 4.5)
			end

			local var_642_3 = 0

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_3 + arg_642_0 then
				arg_639_1.allBtn_.enabled = false
			end

			if arg_639_1.time_ >= var_642_3 + 1.33333333333333 and arg_639_1.time_ < var_642_3 + 1.33333333333333 + arg_642_0 then
				arg_639_1.allBtn_.enabled = true
			end

			if arg_639_1.frameCnt_ <= 1 then
				arg_639_1.dialog_:SetActive(false)
			end

			local var_642_4 = 1.33333333333333
			local var_642_5 = 0.9

			if 1.33333333333333 < arg_639_1.time_ and arg_639_1.time_ <= var_642_4 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0

				arg_639_1.dialog_:SetActive(true)

				arg_639_1.dialogCg_.alpha = 0

				local var_642_6 = LeanTween.value(arg_639_1.dialog_, 0, 1, 0.3)

				var_642_6:setOnUpdate(LuaHelper.FloatAction(function(arg_643_0)
					arg_639_1.dialogCg_.alpha = arg_643_0
				end))
				var_642_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_639_1.dialog_)
					var_642_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_639_1.duration_ = arg_639_1.duration_ + 0.3

				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_7 = arg_639_1:FormatText(arg_639_1:GetWordFromCfg(322151150).content)

				arg_639_1.text_.text = var_642_7

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_9 = 36 <= 0 and var_642_5 or var_642_5 * (utf8.len(var_642_7) / 36)

				if (36 <= 0 and var_642_5 or var_642_5 * (utf8.len(var_642_7) / 36)) > 0 and var_642_5 < var_642_9 then
					arg_639_1.talkMaxDuration = var_642_9
					var_642_4 = var_642_4 + 0.3

					if var_642_9 + var_642_4 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_9 + var_642_4
					end
				end

				arg_639_1.text_.text = var_642_7
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)
				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_10 = var_642_4 + 0.3
			local var_642_11 = math.max(var_642_5, arg_639_1.talkMaxDuration)

			if var_642_4 + 0.3 <= arg_639_1.time_ and arg_639_1.time_ < var_642_10 + var_642_11 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_10) / var_642_11

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_10 + var_642_11 and arg_639_1.time_ < var_642_10 + var_642_11 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2209",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.29933333333333,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play322151151 = function(arg_645_0, arg_645_1)
		arg_645_1.time_ = 0
		arg_645_1.frameCnt_ = 0
		arg_645_1.state_ = "playing"
		arg_645_1.curTalkId_ = 322151151
		arg_645_1.duration_ = 5

		SetActive(arg_645_1.tipsGo_, false)

		function arg_645_1.onSingleLineFinish_()
			arg_645_1.onSingleLineUpdate_ = nil
			arg_645_1.onSingleLineFinish_ = nil
			arg_645_1.state_ = "waiting"
		end

		function arg_645_1.playNext_(arg_647_0)
			if arg_647_0 == 1 then
				arg_645_0:Play322151152(arg_645_1)
			end
		end

		function arg_645_1.onSingleLineUpdate_(arg_648_0)
			local var_648_0 = 0.35

			if 0 < arg_645_1.time_ and arg_645_1.time_ <= 0 + arg_648_0 then
				arg_645_1.talkMaxDuration = 0
				arg_645_1.dialogCg_.alpha = 1

				arg_645_1.dialog_:SetActive(true)
				SetActive(arg_645_1.leftNameGo_, true)

				arg_645_1.leftNameTxt_.text = arg_645_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_645_1.leftNameTxt_.transform)

				arg_645_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_645_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_645_1:RecordName(arg_645_1.leftNameTxt_.text)
				SetActive(arg_645_1.iconTrs_.gameObject, false)
				arg_645_1.callingController_:SetSelectedState("normal")

				local var_648_1 = arg_645_1:FormatText(arg_645_1:GetWordFromCfg(322151151).content)

				arg_645_1.text_.text = var_648_1

				LuaForUtil.ClearLinePrefixSymbol(arg_645_1.text_)

				local var_648_3 = 14 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 14)

				if (14 <= 0 and var_648_0 or var_648_0 * (utf8.len(var_648_1) / 14)) > 0 and var_648_0 < var_648_3 then
					arg_645_1.talkMaxDuration = var_648_3

					if var_648_3 + 0 > arg_645_1.duration_ then
						arg_645_1.duration_ = var_648_3 + 0
					end
				end

				arg_645_1.text_.text = var_648_1
				arg_645_1.typewritter.percent = 0

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(false)
				arg_645_1:RecordContent(arg_645_1.text_.text)
			end

			local var_648_4 = math.max(var_648_0, arg_645_1.talkMaxDuration)

			if 0 <= arg_645_1.time_ and arg_645_1.time_ < 0 + var_648_4 then
				arg_645_1.typewritter.percent = (arg_645_1.time_ - 0) / var_648_4

				arg_645_1.typewritter:SetDirty()
			end

			if arg_645_1.time_ >= 0 + var_648_4 and arg_645_1.time_ < 0 + var_648_4 + arg_648_0 then
				arg_645_1.typewritter.percent = 1

				arg_645_1.typewritter:SetDirty()
				arg_645_1:ShowNextGo(true)
			end
		end

		arg_645_1.nodeConfigList_ = {}

		arg_645_1:InitPlayNodeList()
	end,
	Play322151152 = function(arg_649_0, arg_649_1)
		arg_649_1.time_ = 0
		arg_649_1.frameCnt_ = 0
		arg_649_1.state_ = "playing"
		arg_649_1.curTalkId_ = 322151152
		arg_649_1.duration_ = 5

		SetActive(arg_649_1.tipsGo_, false)

		function arg_649_1.onSingleLineFinish_()
			arg_649_1.onSingleLineUpdate_ = nil
			arg_649_1.onSingleLineFinish_ = nil
			arg_649_1.state_ = "waiting"
		end

		function arg_649_1.playNext_(arg_651_0)
			if arg_651_0 == 1 then
				arg_649_0:Play322151153(arg_649_1)
			end
		end

		function arg_649_1.onSingleLineUpdate_(arg_652_0)
			local var_652_0 = 1.3

			if 0 < arg_649_1.time_ and arg_649_1.time_ <= 0 + arg_652_0 then
				arg_649_1.talkMaxDuration = 0
				arg_649_1.dialogCg_.alpha = 1

				arg_649_1.dialog_:SetActive(true)
				SetActive(arg_649_1.leftNameGo_, false)

				arg_649_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_649_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_649_1:RecordName(arg_649_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_649_1.iconTrs_.gameObject, false)
				arg_649_1.callingController_:SetSelectedState("normal")

				local var_652_1 = arg_649_1:FormatText(arg_649_1:GetWordFromCfg(322151152).content)

				arg_649_1.text_.text = var_652_1

				LuaForUtil.ClearLinePrefixSymbol(arg_649_1.text_)

				local var_652_3 = 52 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 52)

				if (52 <= 0 and var_652_0 or var_652_0 * (utf8.len(var_652_1) / 52)) > 0 and var_652_0 < var_652_3 then
					arg_649_1.talkMaxDuration = var_652_3

					if var_652_3 + 0 > arg_649_1.duration_ then
						arg_649_1.duration_ = var_652_3 + 0
					end
				end

				arg_649_1.text_.text = var_652_1
				arg_649_1.typewritter.percent = 0

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(false)
				arg_649_1:RecordContent(arg_649_1.text_.text)
			end

			local var_652_4 = math.max(var_652_0, arg_649_1.talkMaxDuration)

			if 0 <= arg_649_1.time_ and arg_649_1.time_ < 0 + var_652_4 then
				arg_649_1.typewritter.percent = (arg_649_1.time_ - 0) / var_652_4

				arg_649_1.typewritter:SetDirty()
			end

			if arg_649_1.time_ >= 0 + var_652_4 and arg_649_1.time_ < 0 + var_652_4 + arg_652_0 then
				arg_649_1.typewritter.percent = 1

				arg_649_1.typewritter:SetDirty()
				arg_649_1:ShowNextGo(true)
			end
		end

		arg_649_1.nodeConfigList_ = {}

		arg_649_1:InitPlayNodeList()
	end,
	Play322151153 = function(arg_653_0, arg_653_1)
		arg_653_1.time_ = 0
		arg_653_1.frameCnt_ = 0
		arg_653_1.state_ = "playing"
		arg_653_1.curTalkId_ = 322151153
		arg_653_1.duration_ = 5

		SetActive(arg_653_1.tipsGo_, false)

		function arg_653_1.onSingleLineFinish_()
			arg_653_1.onSingleLineUpdate_ = nil
			arg_653_1.onSingleLineFinish_ = nil
			arg_653_1.state_ = "waiting"
		end

		function arg_653_1.playNext_(arg_655_0)
			if arg_655_0 == 1 then
				arg_653_0:Play322151154(arg_653_1)
			end
		end

		function arg_653_1.onSingleLineUpdate_(arg_656_0)
			if 0.1 < arg_653_1.time_ and arg_653_1.time_ <= 0.1 + arg_656_0 then
				arg_653_1:AudioAction("play", "effect", "minigame_activity_3_7", "minigame_activity_3_7_bullet_laser", "")
			end

			local var_656_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_653_1.time_ and arg_653_1.time_ <= 0.1 + arg_656_0 then
				arg_653_1.var_.shakeOldPos = var_656_1.localPosition
			end

			local var_656_2 = 0.5

			if 0.1 <= arg_653_1.time_ and arg_653_1.time_ < 0.1 + var_656_2 then
				local var_656_3, var_656_4 = math.modf((arg_653_1.time_ - 0.1) / 0.066)

				var_656_1.localPosition = Vector3.New(var_656_4 * 0.13, var_656_4 * 0.13, var_656_4 * 0.13) + arg_653_1.var_.shakeOldPos
			end

			if arg_653_1.time_ >= 0.1 + var_656_2 and arg_653_1.time_ < 0.1 + var_656_2 + arg_656_0 then
				var_656_1.localPosition = arg_653_1.var_.shakeOldPos
			end

			local var_656_5 = 0
			local var_656_6 = 1.6

			if 0 < arg_653_1.time_ and arg_653_1.time_ <= var_656_5 + arg_656_0 then
				arg_653_1.talkMaxDuration = 0
				arg_653_1.dialogCg_.alpha = 1

				arg_653_1.dialog_:SetActive(true)
				SetActive(arg_653_1.leftNameGo_, false)

				arg_653_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_653_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_653_1:RecordName(arg_653_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_653_1.iconTrs_.gameObject, false)
				arg_653_1.callingController_:SetSelectedState("normal")

				local var_656_7 = arg_653_1:FormatText(arg_653_1:GetWordFromCfg(322151153).content)

				arg_653_1.text_.text = var_656_7

				LuaForUtil.ClearLinePrefixSymbol(arg_653_1.text_)

				local var_656_9 = 64 <= 0 and var_656_6 or var_656_6 * (utf8.len(var_656_7) / 64)

				if (64 <= 0 and var_656_6 or var_656_6 * (utf8.len(var_656_7) / 64)) > 0 and var_656_6 < var_656_9 then
					arg_653_1.talkMaxDuration = var_656_9

					if var_656_9 + var_656_5 > arg_653_1.duration_ then
						arg_653_1.duration_ = var_656_9 + var_656_5
					end
				end

				arg_653_1.text_.text = var_656_7
				arg_653_1.typewritter.percent = 0

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(false)
				arg_653_1:RecordContent(arg_653_1.text_.text)
			end

			local var_656_10 = math.max(var_656_6, arg_653_1.talkMaxDuration)

			if var_656_5 <= arg_653_1.time_ and arg_653_1.time_ < var_656_5 + var_656_10 then
				arg_653_1.typewritter.percent = (arg_653_1.time_ - var_656_5) / var_656_10

				arg_653_1.typewritter:SetDirty()
			end

			if arg_653_1.time_ >= var_656_5 + var_656_10 and arg_653_1.time_ < var_656_5 + var_656_10 + arg_656_0 then
				arg_653_1.typewritter.percent = 1

				arg_653_1.typewritter:SetDirty()
				arg_653_1:ShowNextGo(true)
			end
		end

		arg_653_1.nodeConfigList_ = {}

		arg_653_1:InitPlayNodeList()
	end,
	Play322151154 = function(arg_657_0, arg_657_1)
		arg_657_1.time_ = 0
		arg_657_1.frameCnt_ = 0
		arg_657_1.state_ = "playing"
		arg_657_1.curTalkId_ = 322151154
		arg_657_1.duration_ = 5.27

		local var_657_0 = {
			zh = 3.233,
			ja = 5.266
		}
		local var_657_1 = manager.audio:GetLocalizationFlag()

		if var_657_0[var_657_1] ~= nil then
			arg_657_1.duration_ = var_657_0[var_657_1]
		end

		SetActive(arg_657_1.tipsGo_, false)

		function arg_657_1.onSingleLineFinish_()
			arg_657_1.onSingleLineUpdate_ = nil
			arg_657_1.onSingleLineFinish_ = nil
			arg_657_1.state_ = "waiting"
		end

		function arg_657_1.playNext_(arg_659_0)
			if arg_659_0 == 1 then
				arg_657_0:Play322151155(arg_657_1)
			end
		end

		function arg_657_1.onSingleLineUpdate_(arg_660_0)
			local var_660_0 = 0.3

			if 0 < arg_657_1.time_ and arg_657_1.time_ <= 0 + arg_660_0 then
				arg_657_1.talkMaxDuration = 0
				arg_657_1.dialogCg_.alpha = 1

				arg_657_1.dialog_:SetActive(true)
				SetActive(arg_657_1.leftNameGo_, true)

				arg_657_1.leftNameTxt_.text = arg_657_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_657_1.leftNameTxt_.transform)

				arg_657_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_657_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_657_1:RecordName(arg_657_1.leftNameTxt_.text)
				SetActive(arg_657_1.iconTrs_.gameObject, false)
				arg_657_1.callingController_:SetSelectedState("normal")

				local var_660_1 = arg_657_1:GetWordFromCfg(322151154)
				local var_660_2 = arg_657_1:FormatText(var_660_1.content)

				arg_657_1.text_.text = var_660_2

				LuaForUtil.ClearLinePrefixSymbol(arg_657_1.text_)

				local var_660_4 = 12 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_2) / 12)

				if (12 <= 0 and var_660_0 or var_660_0 * (utf8.len(var_660_2) / 12)) > 0 and var_660_0 < var_660_4 then
					arg_657_1.talkMaxDuration = var_660_4

					if var_660_4 + 0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_4 + 0
					end
				end

				arg_657_1.text_.text = var_660_2
				arg_657_1.typewritter.percent = 0

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151154", "story_v_out_322151.awb") ~= 0 then
					local var_660_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151154", "story_v_out_322151.awb") / 1000

					if var_660_5 + 0 > arg_657_1.duration_ then
						arg_657_1.duration_ = var_660_5 + 0
					end

					if var_660_1.prefab_name ~= "" and arg_657_1.actors_[var_660_1.prefab_name] ~= nil then
						local var_660_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_657_1.actors_[var_660_1.prefab_name].transform, "story_v_out_322151", "322151154", "story_v_out_322151.awb")

						arg_657_1:RecordAudio("322151154", var_660_6)
						arg_657_1:RecordAudio("322151154", var_660_6)
					else
						arg_657_1:AudioAction("play", "voice", "story_v_out_322151", "322151154", "story_v_out_322151.awb")
					end

					arg_657_1:RecordHistoryTalkVoice("story_v_out_322151", "322151154", "story_v_out_322151.awb")
				end

				arg_657_1:RecordContent(arg_657_1.text_.text)
			end

			local var_660_7 = math.max(var_660_0, arg_657_1.talkMaxDuration)

			if 0 <= arg_657_1.time_ and arg_657_1.time_ < 0 + var_660_7 then
				arg_657_1.typewritter.percent = (arg_657_1.time_ - 0) / var_660_7

				arg_657_1.typewritter:SetDirty()
			end

			if arg_657_1.time_ >= 0 + var_660_7 and arg_657_1.time_ < 0 + var_660_7 + arg_660_0 then
				arg_657_1.typewritter.percent = 1

				arg_657_1.typewritter:SetDirty()
				arg_657_1:ShowNextGo(true)
			end
		end

		arg_657_1.nodeConfigList_ = {}

		arg_657_1:InitPlayNodeList()
	end,
	Play322151155 = function(arg_661_0, arg_661_1)
		arg_661_1.time_ = 0
		arg_661_1.frameCnt_ = 0
		arg_661_1.state_ = "playing"
		arg_661_1.curTalkId_ = 322151155
		arg_661_1.duration_ = 5

		SetActive(arg_661_1.tipsGo_, false)

		function arg_661_1.onSingleLineFinish_()
			arg_661_1.onSingleLineUpdate_ = nil
			arg_661_1.onSingleLineFinish_ = nil
			arg_661_1.state_ = "waiting"
		end

		function arg_661_1.playNext_(arg_663_0)
			if arg_663_0 == 1 then
				arg_661_0:Play322151156(arg_661_1)
			end
		end

		function arg_661_1.onSingleLineUpdate_(arg_664_0)
			local var_664_0 = 0.7

			if 0 < arg_661_1.time_ and arg_661_1.time_ <= 0 + arg_664_0 then
				arg_661_1.talkMaxDuration = 0
				arg_661_1.dialogCg_.alpha = 1

				arg_661_1.dialog_:SetActive(true)
				SetActive(arg_661_1.leftNameGo_, true)

				arg_661_1.leftNameTxt_.text = arg_661_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_661_1.leftNameTxt_.transform)

				arg_661_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_661_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_661_1:RecordName(arg_661_1.leftNameTxt_.text)
				SetActive(arg_661_1.iconTrs_.gameObject, false)
				arg_661_1.callingController_:SetSelectedState("normal")

				local var_664_1 = arg_661_1:FormatText(arg_661_1:GetWordFromCfg(322151155).content)

				arg_661_1.text_.text = var_664_1

				LuaForUtil.ClearLinePrefixSymbol(arg_661_1.text_)

				local var_664_3 = 28 <= 0 and var_664_0 or var_664_0 * (utf8.len(var_664_1) / 28)

				if (28 <= 0 and var_664_0 or var_664_0 * (utf8.len(var_664_1) / 28)) > 0 and var_664_0 < var_664_3 then
					arg_661_1.talkMaxDuration = var_664_3

					if var_664_3 + 0 > arg_661_1.duration_ then
						arg_661_1.duration_ = var_664_3 + 0
					end
				end

				arg_661_1.text_.text = var_664_1
				arg_661_1.typewritter.percent = 0

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(false)
				arg_661_1:RecordContent(arg_661_1.text_.text)
			end

			local var_664_4 = math.max(var_664_0, arg_661_1.talkMaxDuration)

			if 0 <= arg_661_1.time_ and arg_661_1.time_ < 0 + var_664_4 then
				arg_661_1.typewritter.percent = (arg_661_1.time_ - 0) / var_664_4

				arg_661_1.typewritter:SetDirty()
			end

			if arg_661_1.time_ >= 0 + var_664_4 and arg_661_1.time_ < 0 + var_664_4 + arg_664_0 then
				arg_661_1.typewritter.percent = 1

				arg_661_1.typewritter:SetDirty()
				arg_661_1:ShowNextGo(true)
			end
		end

		arg_661_1.nodeConfigList_ = {}

		arg_661_1:InitPlayNodeList()
	end,
	Play322151156 = function(arg_665_0, arg_665_1)
		arg_665_1.time_ = 0
		arg_665_1.frameCnt_ = 0
		arg_665_1.state_ = "playing"
		arg_665_1.curTalkId_ = 322151156
		arg_665_1.duration_ = 5.82

		local var_665_0 = {
			zh = 5.38266666666667,
			ja = 5.81666666666667
		}
		local var_665_1 = manager.audio:GetLocalizationFlag()

		if var_665_0[var_665_1] ~= nil then
			arg_665_1.duration_ = var_665_0[var_665_1]
		end

		SetActive(arg_665_1.tipsGo_, false)

		function arg_665_1.onSingleLineFinish_()
			arg_665_1.onSingleLineUpdate_ = nil
			arg_665_1.onSingleLineFinish_ = nil
			arg_665_1.state_ = "waiting"
		end

		function arg_665_1.playNext_(arg_667_0)
			if arg_667_0 == 1 then
				arg_665_0:Play322151157(arg_665_1)
			end
		end

		function arg_665_1.onSingleLineUpdate_(arg_668_0)
			if 0 < arg_665_1.time_ and arg_665_1.time_ <= 0 + arg_668_0 then
				arg_665_1.var_.moveOldPosMS2209 = arg_665_1.bgs_.MS2209.transform.localPosition
			end

			local var_668_0 = 0.316666666666667

			if 0 <= arg_665_1.time_ and arg_665_1.time_ < 0 + var_668_0 then
				arg_665_1.bgs_.MS2209.transform.localPosition = Vector3.Lerp(arg_665_1.var_.moveOldPosMS2209, Vector3.New(-0.1, 2.6, 4.5), (arg_665_1.time_ - 0) / var_668_0)
			end

			if arg_665_1.time_ >= 0 + var_668_0 and arg_665_1.time_ < 0 + var_668_0 + arg_668_0 then
				arg_665_1.bgs_.MS2209.transform.localPosition = Vector3.New(-0.1, 2.6, 4.5)
			end

			local var_668_1 = 0

			if 0 < arg_665_1.time_ and arg_665_1.time_ <= var_668_1 + arg_668_0 then
				arg_665_1.allBtn_.enabled = false
			end

			if arg_665_1.time_ >= var_668_1 + 0.466666666666667 and arg_665_1.time_ < var_668_1 + 0.466666666666667 + arg_668_0 then
				arg_665_1.allBtn_.enabled = true
			end

			if arg_665_1.frameCnt_ <= 1 then
				arg_665_1.dialog_:SetActive(false)
			end

			local var_668_2 = 0.316666666666667
			local var_668_3 = 0.425

			if 0.316666666666667 < arg_665_1.time_ and arg_665_1.time_ <= var_668_2 + arg_668_0 then
				arg_665_1.talkMaxDuration = 0

				arg_665_1.dialog_:SetActive(true)

				arg_665_1.dialogCg_.alpha = 0

				local var_668_4 = LeanTween.value(arg_665_1.dialog_, 0, 1, 0.3)

				var_668_4:setOnUpdate(LuaHelper.FloatAction(function(arg_669_0)
					arg_665_1.dialogCg_.alpha = arg_669_0
				end))
				var_668_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_665_1.dialog_)
					var_668_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_665_1.duration_ = arg_665_1.duration_ + 0.3

				SetActive(arg_665_1.leftNameGo_, true)

				arg_665_1.leftNameTxt_.text = arg_665_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_665_1.leftNameTxt_.transform)

				arg_665_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_665_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_665_1:RecordName(arg_665_1.leftNameTxt_.text)
				SetActive(arg_665_1.iconTrs_.gameObject, false)
				arg_665_1.callingController_:SetSelectedState("normal")

				local var_668_5 = arg_665_1:GetWordFromCfg(322151156)
				local var_668_6 = arg_665_1:FormatText(var_668_5.content)

				arg_665_1.text_.text = var_668_6

				LuaForUtil.ClearLinePrefixSymbol(arg_665_1.text_)

				local var_668_8 = 17 <= 0 and var_668_3 or var_668_3 * (utf8.len(var_668_6) / 17)

				if (17 <= 0 and var_668_3 or var_668_3 * (utf8.len(var_668_6) / 17)) > 0 and var_668_3 < var_668_8 then
					arg_665_1.talkMaxDuration = var_668_8
					var_668_2 = var_668_2 + 0.3

					if var_668_8 + var_668_2 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_8 + var_668_2
					end
				end

				arg_665_1.text_.text = var_668_6
				arg_665_1.typewritter.percent = 0

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151156", "story_v_out_322151.awb") ~= 0 then
					local var_668_9 = manager.audio:GetVoiceLength("story_v_out_322151", "322151156", "story_v_out_322151.awb") / 1000

					if var_668_9 + var_668_2 > arg_665_1.duration_ then
						arg_665_1.duration_ = var_668_9 + var_668_2
					end

					if var_668_5.prefab_name ~= "" and arg_665_1.actors_[var_668_5.prefab_name] ~= nil then
						local var_668_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_665_1.actors_[var_668_5.prefab_name].transform, "story_v_out_322151", "322151156", "story_v_out_322151.awb")

						arg_665_1:RecordAudio("322151156", var_668_10)
						arg_665_1:RecordAudio("322151156", var_668_10)
					else
						arg_665_1:AudioAction("play", "voice", "story_v_out_322151", "322151156", "story_v_out_322151.awb")
					end

					arg_665_1:RecordHistoryTalkVoice("story_v_out_322151", "322151156", "story_v_out_322151.awb")
				end

				arg_665_1:RecordContent(arg_665_1.text_.text)
			end

			local var_668_11 = var_668_2 + 0.3
			local var_668_12 = math.max(var_668_3, arg_665_1.talkMaxDuration)

			if var_668_2 + 0.3 <= arg_665_1.time_ and arg_665_1.time_ < var_668_11 + var_668_12 then
				arg_665_1.typewritter.percent = (arg_665_1.time_ - var_668_11) / var_668_12

				arg_665_1.typewritter:SetDirty()
			end

			if arg_665_1.time_ >= var_668_11 + var_668_12 and arg_665_1.time_ < var_668_11 + var_668_12 + arg_668_0 then
				arg_665_1.typewritter.percent = 1

				arg_665_1.typewritter:SetDirty()
				arg_665_1:ShowNextGo(true)
			end
		end

		arg_665_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.316666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 2.6, 4.5),
					endPos = Vector3.New(-0.1, 2.6, 4.5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_665_1:InitPlayNodeList()
	end,
	Play322151157 = function(arg_671_0, arg_671_1)
		arg_671_1.time_ = 0
		arg_671_1.frameCnt_ = 0
		arg_671_1.state_ = "playing"
		arg_671_1.curTalkId_ = 322151157
		arg_671_1.duration_ = 5

		SetActive(arg_671_1.tipsGo_, false)

		function arg_671_1.onSingleLineFinish_()
			arg_671_1.onSingleLineUpdate_ = nil
			arg_671_1.onSingleLineFinish_ = nil
			arg_671_1.state_ = "waiting"
		end

		function arg_671_1.playNext_(arg_673_0)
			if arg_673_0 == 1 then
				arg_671_0:Play322151158(arg_671_1)
			end
		end

		function arg_671_1.onSingleLineUpdate_(arg_674_0)
			local var_674_0 = 0.85

			if 0 < arg_671_1.time_ and arg_671_1.time_ <= 0 + arg_674_0 then
				arg_671_1.talkMaxDuration = 0
				arg_671_1.dialogCg_.alpha = 1

				arg_671_1.dialog_:SetActive(true)
				SetActive(arg_671_1.leftNameGo_, false)

				arg_671_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_671_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_671_1:RecordName(arg_671_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_671_1.iconTrs_.gameObject, false)
				arg_671_1.callingController_:SetSelectedState("normal")

				local var_674_1 = arg_671_1:FormatText(arg_671_1:GetWordFromCfg(322151157).content)

				arg_671_1.text_.text = var_674_1

				LuaForUtil.ClearLinePrefixSymbol(arg_671_1.text_)

				local var_674_3 = 34 <= 0 and var_674_0 or var_674_0 * (utf8.len(var_674_1) / 34)

				if (34 <= 0 and var_674_0 or var_674_0 * (utf8.len(var_674_1) / 34)) > 0 and var_674_0 < var_674_3 then
					arg_671_1.talkMaxDuration = var_674_3

					if var_674_3 + 0 > arg_671_1.duration_ then
						arg_671_1.duration_ = var_674_3 + 0
					end
				end

				arg_671_1.text_.text = var_674_1
				arg_671_1.typewritter.percent = 0

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(false)
				arg_671_1:RecordContent(arg_671_1.text_.text)
			end

			local var_674_4 = math.max(var_674_0, arg_671_1.talkMaxDuration)

			if 0 <= arg_671_1.time_ and arg_671_1.time_ < 0 + var_674_4 then
				arg_671_1.typewritter.percent = (arg_671_1.time_ - 0) / var_674_4

				arg_671_1.typewritter:SetDirty()
			end

			if arg_671_1.time_ >= 0 + var_674_4 and arg_671_1.time_ < 0 + var_674_4 + arg_674_0 then
				arg_671_1.typewritter.percent = 1

				arg_671_1.typewritter:SetDirty()
				arg_671_1:ShowNextGo(true)
			end
		end

		arg_671_1.nodeConfigList_ = {}

		arg_671_1:InitPlayNodeList()
	end,
	Play322151158 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 322151158
		arg_675_1.duration_ = 5

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play322151159(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			local var_678_0 = 0.375

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_1 = arg_675_1:FormatText(arg_675_1:GetWordFromCfg(322151158).content)

				arg_675_1.text_.text = var_678_1

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_3 = 15 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_1) / 15)

				if (15 <= 0 and var_678_0 or var_678_0 * (utf8.len(var_678_1) / 15)) > 0 and var_678_0 < var_678_3 then
					arg_675_1.talkMaxDuration = var_678_3

					if var_678_3 + 0 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_3 + 0
					end
				end

				arg_675_1.text_.text = var_678_1
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)
				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_4 = math.max(var_678_0, arg_675_1.talkMaxDuration)

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_4 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - 0) / var_678_4

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= 0 + var_678_4 and arg_675_1.time_ < 0 + var_678_4 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {}

		arg_675_1:InitPlayNodeList()
	end,
	Play322151159 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 322151159
		arg_679_1.duration_ = 4.7

		local var_679_0 = {
			zh = 3.69933333333333,
			ja = 4.69933333333333
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play322151160(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_682_0 = 0.233333333333333

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 then
				local var_682_1, var_682_2 = math.modf((arg_679_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_682_2 * 0.13, var_682_2 * 0.13, var_682_2 * 0.13) + arg_679_1.var_.shakeOldPos
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 then
				manager.ui.mainCamera.transform.localPosition = arg_679_1.var_.shakeOldPos
			end

			if arg_679_1.frameCnt_ <= 1 then
				arg_679_1.dialog_:SetActive(false)
			end

			local var_682_3 = 0.233333333333333
			local var_682_4 = 0.275

			if 0.233333333333333 < arg_679_1.time_ and arg_679_1.time_ <= var_682_3 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0

				arg_679_1.dialog_:SetActive(true)

				arg_679_1.dialogCg_.alpha = 0

				local var_682_5 = LeanTween.value(arg_679_1.dialog_, 0, 1, 0.3)

				var_682_5:setOnUpdate(LuaHelper.FloatAction(function(arg_683_0)
					arg_679_1.dialogCg_.alpha = arg_683_0
				end))
				var_682_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_679_1.dialog_)
					var_682_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_679_1.duration_ = arg_679_1.duration_ + 0.3

				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_6 = arg_679_1:GetWordFromCfg(322151159)
				local var_682_7 = arg_679_1:FormatText(var_682_6.content)

				arg_679_1.text_.text = var_682_7

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_9 = 11 <= 0 and var_682_4 or var_682_4 * (utf8.len(var_682_7) / 11)

				if (11 <= 0 and var_682_4 or var_682_4 * (utf8.len(var_682_7) / 11)) > 0 and var_682_4 < var_682_9 then
					arg_679_1.talkMaxDuration = var_682_9
					var_682_3 = var_682_3 + 0.3

					if var_682_9 + var_682_3 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_9 + var_682_3
					end
				end

				arg_679_1.text_.text = var_682_7
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151159", "story_v_out_322151.awb") ~= 0 then
					local var_682_10 = manager.audio:GetVoiceLength("story_v_out_322151", "322151159", "story_v_out_322151.awb") / 1000

					if var_682_10 + var_682_3 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_10 + var_682_3
					end

					if var_682_6.prefab_name ~= "" and arg_679_1.actors_[var_682_6.prefab_name] ~= nil then
						local var_682_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_6.prefab_name].transform, "story_v_out_322151", "322151159", "story_v_out_322151.awb")

						arg_679_1:RecordAudio("322151159", var_682_11)
						arg_679_1:RecordAudio("322151159", var_682_11)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_out_322151", "322151159", "story_v_out_322151.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_out_322151", "322151159", "story_v_out_322151.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_12 = var_682_3 + 0.3
			local var_682_13 = math.max(var_682_4, arg_679_1.talkMaxDuration)

			if var_682_3 + 0.3 <= arg_679_1.time_ and arg_679_1.time_ < var_682_12 + var_682_13 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_12) / var_682_13

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_12 + var_682_13 and arg_679_1.time_ < var_682_12 + var_682_13 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {}

		arg_679_1:InitPlayNodeList()
	end,
	Play322151160 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 322151160
		arg_685_1.duration_ = 4.33

		local var_685_0 = {
			zh = 3.066,
			ja = 4.333
		}
		local var_685_1 = manager.audio:GetLocalizationFlag()

		if var_685_0[var_685_1] ~= nil then
			arg_685_1.duration_ = var_685_0[var_685_1]
		end

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play322151161(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = 0.35

			if 0 < arg_685_1.time_ and arg_685_1.time_ <= 0 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				arg_685_1.leftNameTxt_.text = arg_685_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_1 = arg_685_1:GetWordFromCfg(322151160)
				local var_688_2 = arg_685_1:FormatText(var_688_1.content)

				arg_685_1.text_.text = var_688_2

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_4 = 14 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_2) / 14)

				if (14 <= 0 and var_688_0 or var_688_0 * (utf8.len(var_688_2) / 14)) > 0 and var_688_0 < var_688_4 then
					arg_685_1.talkMaxDuration = var_688_4

					if var_688_4 + 0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_4 + 0
					end
				end

				arg_685_1.text_.text = var_688_2
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151160", "story_v_out_322151.awb") ~= 0 then
					local var_688_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151160", "story_v_out_322151.awb") / 1000

					if var_688_5 + 0 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_5 + 0
					end

					if var_688_1.prefab_name ~= "" and arg_685_1.actors_[var_688_1.prefab_name] ~= nil then
						local var_688_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_685_1.actors_[var_688_1.prefab_name].transform, "story_v_out_322151", "322151160", "story_v_out_322151.awb")

						arg_685_1:RecordAudio("322151160", var_688_6)
						arg_685_1:RecordAudio("322151160", var_688_6)
					else
						arg_685_1:AudioAction("play", "voice", "story_v_out_322151", "322151160", "story_v_out_322151.awb")
					end

					arg_685_1:RecordHistoryTalkVoice("story_v_out_322151", "322151160", "story_v_out_322151.awb")
				end

				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_7 = math.max(var_688_0, arg_685_1.talkMaxDuration)

			if 0 <= arg_685_1.time_ and arg_685_1.time_ < 0 + var_688_7 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - 0) / var_688_7

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= 0 + var_688_7 and arg_685_1.time_ < 0 + var_688_7 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {}

		arg_685_1:InitPlayNodeList()
	end,
	Play322151161 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 322151161
		arg_689_1.duration_ = 5.53

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play322151162(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			if 0 < arg_689_1.time_ and arg_689_1.time_ <= 0 + arg_692_0 then
				arg_689_1.var_.moveOldPosMS2209 = arg_689_1.bgs_.MS2209.transform.localPosition
			end

			local var_692_0 = 0.533333333333333

			if 0 <= arg_689_1.time_ and arg_689_1.time_ < 0 + var_692_0 then
				arg_689_1.bgs_.MS2209.transform.localPosition = Vector3.Lerp(arg_689_1.var_.moveOldPosMS2209, Vector3.New(0, 2.6, 4.5), (arg_689_1.time_ - 0) / var_692_0)
			end

			if arg_689_1.time_ >= 0 + var_692_0 and arg_689_1.time_ < 0 + var_692_0 + arg_692_0 then
				arg_689_1.bgs_.MS2209.transform.localPosition = Vector3.New(0, 2.6, 4.5)
			end

			local var_692_1 = 0

			if 0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 then
				arg_689_1.allBtn_.enabled = false
			end

			if arg_689_1.time_ >= var_692_1 + 0.733333333333333 and arg_689_1.time_ < var_692_1 + 0.733333333333333 + arg_692_0 then
				arg_689_1.allBtn_.enabled = true
			end

			if arg_689_1.frameCnt_ <= 1 then
				arg_689_1.dialog_:SetActive(false)
			end

			local var_692_2 = 0.533333333333333
			local var_692_3 = 0.575

			if 0.533333333333333 < arg_689_1.time_ and arg_689_1.time_ <= var_692_2 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0

				arg_689_1.dialog_:SetActive(true)

				arg_689_1.dialogCg_.alpha = 0

				local var_692_4 = LeanTween.value(arg_689_1.dialog_, 0, 1, 0.3)

				var_692_4:setOnUpdate(LuaHelper.FloatAction(function(arg_693_0)
					arg_689_1.dialogCg_.alpha = arg_693_0
				end))
				var_692_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_689_1.dialog_)
					var_692_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_689_1.duration_ = arg_689_1.duration_ + 0.3

				SetActive(arg_689_1.leftNameGo_, true)

				arg_689_1.leftNameTxt_.text = arg_689_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_5 = arg_689_1:FormatText(arg_689_1:GetWordFromCfg(322151161).content)

				arg_689_1.text_.text = var_692_5

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_7 = 23 <= 0 and var_692_3 or var_692_3 * (utf8.len(var_692_5) / 23)

				if (23 <= 0 and var_692_3 or var_692_3 * (utf8.len(var_692_5) / 23)) > 0 and var_692_3 < var_692_7 then
					arg_689_1.talkMaxDuration = var_692_7
					var_692_2 = var_692_2 + 0.3

					if var_692_7 + var_692_2 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_7 + var_692_2
					end
				end

				arg_689_1.text_.text = var_692_5
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_8 = var_692_2 + 0.3
			local var_692_9 = math.max(var_692_3, arg_689_1.talkMaxDuration)

			if var_692_2 + 0.3 <= arg_689_1.time_ and arg_689_1.time_ < var_692_8 + var_692_9 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_8) / var_692_9

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_8 + var_692_9 and arg_689_1.time_ < var_692_8 + var_692_9 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2209",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.533333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-0.1, 2.6, 4.5),
					endPos = Vector3.New(0, 2.6, 4.5),
					easeType = LeanTweenType.easeInOutQuad
				}
			}
		}

		arg_689_1:InitPlayNodeList()
	end,
	Play322151162 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 322151162
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play322151163(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			local var_698_0 = 1.225

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, true)

				arg_695_1.leftNameTxt_.text = arg_695_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_695_1.leftNameTxt_.transform)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1.leftNameTxt_.text)
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_1 = arg_695_1:FormatText(arg_695_1:GetWordFromCfg(322151162).content)

				arg_695_1.text_.text = var_698_1

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_3 = 49 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_1) / 49)

				if (49 <= 0 and var_698_0 or var_698_0 * (utf8.len(var_698_1) / 49)) > 0 and var_698_0 < var_698_3 then
					arg_695_1.talkMaxDuration = var_698_3

					if var_698_3 + 0 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_3 + 0
					end
				end

				arg_695_1.text_.text = var_698_1
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_4 = math.max(var_698_0, arg_695_1.talkMaxDuration)

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_4 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - 0) / var_698_4

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= 0 + var_698_4 and arg_695_1.time_ < 0 + var_698_4 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {}

		arg_695_1:InitPlayNodeList()
	end,
	Play322151163 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 322151163
		arg_699_1.duration_ = 5.23

		local var_699_0 = {
			zh = 3.166,
			ja = 5.233
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play322151164(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			local var_702_0 = 0.3

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_1 = arg_699_1:GetWordFromCfg(322151163)
				local var_702_2 = arg_699_1:FormatText(var_702_1.content)

				arg_699_1.text_.text = var_702_2

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_4 = 12 <= 0 and var_702_0 or var_702_0 * (utf8.len(var_702_2) / 12)

				if (12 <= 0 and var_702_0 or var_702_0 * (utf8.len(var_702_2) / 12)) > 0 and var_702_0 < var_702_4 then
					arg_699_1.talkMaxDuration = var_702_4

					if var_702_4 + 0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_4 + 0
					end
				end

				arg_699_1.text_.text = var_702_2
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151163", "story_v_out_322151.awb") ~= 0 then
					local var_702_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151163", "story_v_out_322151.awb") / 1000

					if var_702_5 + 0 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_5 + 0
					end

					if var_702_1.prefab_name ~= "" and arg_699_1.actors_[var_702_1.prefab_name] ~= nil then
						local var_702_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_1.prefab_name].transform, "story_v_out_322151", "322151163", "story_v_out_322151.awb")

						arg_699_1:RecordAudio("322151163", var_702_6)
						arg_699_1:RecordAudio("322151163", var_702_6)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_322151", "322151163", "story_v_out_322151.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_322151", "322151163", "story_v_out_322151.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_7 = math.max(var_702_0, arg_699_1.talkMaxDuration)

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_7 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - 0) / var_702_7

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= 0 + var_702_7 and arg_699_1.time_ < 0 + var_702_7 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {}

		arg_699_1:InitPlayNodeList()
	end,
	Play322151164 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 322151164
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play322151165(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			local var_706_0 = 1.225

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, false)
				arg_703_1.callingController_:SetSelectedState("normal")

				local var_706_1 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(322151164).content)

				arg_703_1.text_.text = var_706_1

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_3 = 49 <= 0 and var_706_0 or var_706_0 * (utf8.len(var_706_1) / 49)

				if (49 <= 0 and var_706_0 or var_706_0 * (utf8.len(var_706_1) / 49)) > 0 and var_706_0 < var_706_3 then
					arg_703_1.talkMaxDuration = var_706_3

					if var_706_3 + 0 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_3 + 0
					end
				end

				arg_703_1.text_.text = var_706_1
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_4 = math.max(var_706_0, arg_703_1.talkMaxDuration)

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_4 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - 0) / var_706_4

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= 0 + var_706_4 and arg_703_1.time_ < 0 + var_706_4 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play322151165 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 322151165
		arg_707_1.duration_ = 5

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play322151166(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			local var_710_0 = 0.85

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_1 = arg_707_1:FormatText(arg_707_1:GetWordFromCfg(322151165).content)

				arg_707_1.text_.text = var_710_1

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_3 = 34 <= 0 and var_710_0 or var_710_0 * (utf8.len(var_710_1) / 34)

				if (34 <= 0 and var_710_0 or var_710_0 * (utf8.len(var_710_1) / 34)) > 0 and var_710_0 < var_710_3 then
					arg_707_1.talkMaxDuration = var_710_3

					if var_710_3 + 0 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_3 + 0
					end
				end

				arg_707_1.text_.text = var_710_1
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)
				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_4 = math.max(var_710_0, arg_707_1.talkMaxDuration)

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_4 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - 0) / var_710_4

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= 0 + var_710_4 and arg_707_1.time_ < 0 + var_710_4 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {}

		arg_707_1:InitPlayNodeList()
	end,
	Play322151166 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 322151166
		arg_711_1.duration_ = 4.2

		local var_711_0 = {
			zh = 3.566,
			ja = 4.2
		}
		local var_711_1 = manager.audio:GetLocalizationFlag()

		if var_711_0[var_711_1] ~= nil then
			arg_711_1.duration_ = var_711_0[var_711_1]
		end

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play322151167(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			local var_714_0 = 0.375

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, false)
				arg_711_1.callingController_:SetSelectedState("normal")

				local var_714_1 = arg_711_1:GetWordFromCfg(322151166)
				local var_714_2 = arg_711_1:FormatText(var_714_1.content)

				arg_711_1.text_.text = var_714_2

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_4 = 15 <= 0 and var_714_0 or var_714_0 * (utf8.len(var_714_2) / 15)

				if (15 <= 0 and var_714_0 or var_714_0 * (utf8.len(var_714_2) / 15)) > 0 and var_714_0 < var_714_4 then
					arg_711_1.talkMaxDuration = var_714_4

					if var_714_4 + 0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_4 + 0
					end
				end

				arg_711_1.text_.text = var_714_2
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151166", "story_v_out_322151.awb") ~= 0 then
					local var_714_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151166", "story_v_out_322151.awb") / 1000

					if var_714_5 + 0 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_5 + 0
					end

					if var_714_1.prefab_name ~= "" and arg_711_1.actors_[var_714_1.prefab_name] ~= nil then
						local var_714_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_711_1.actors_[var_714_1.prefab_name].transform, "story_v_out_322151", "322151166", "story_v_out_322151.awb")

						arg_711_1:RecordAudio("322151166", var_714_6)
						arg_711_1:RecordAudio("322151166", var_714_6)
					else
						arg_711_1:AudioAction("play", "voice", "story_v_out_322151", "322151166", "story_v_out_322151.awb")
					end

					arg_711_1:RecordHistoryTalkVoice("story_v_out_322151", "322151166", "story_v_out_322151.awb")
				end

				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_7 = math.max(var_714_0, arg_711_1.talkMaxDuration)

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_7 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - 0) / var_714_7

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= 0 + var_714_7 and arg_711_1.time_ < 0 + var_714_7 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play322151167 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 322151167
		arg_715_1.duration_ = 5.37

		local var_715_0 = {
			zh = 3.966,
			ja = 5.366
		}
		local var_715_1 = manager.audio:GetLocalizationFlag()

		if var_715_0[var_715_1] ~= nil then
			arg_715_1.duration_ = var_715_0[var_715_1]
		end

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play322151168(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			local var_718_0 = 0.35

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				arg_715_1.leftNameTxt_.text = arg_715_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_1 = arg_715_1:GetWordFromCfg(322151167)
				local var_718_2 = arg_715_1:FormatText(var_718_1.content)

				arg_715_1.text_.text = var_718_2

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_4 = 14 <= 0 and var_718_0 or var_718_0 * (utf8.len(var_718_2) / 14)

				if (14 <= 0 and var_718_0 or var_718_0 * (utf8.len(var_718_2) / 14)) > 0 and var_718_0 < var_718_4 then
					arg_715_1.talkMaxDuration = var_718_4

					if var_718_4 + 0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_4 + 0
					end
				end

				arg_715_1.text_.text = var_718_2
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151167", "story_v_out_322151.awb") ~= 0 then
					local var_718_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151167", "story_v_out_322151.awb") / 1000

					if var_718_5 + 0 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_5 + 0
					end

					if var_718_1.prefab_name ~= "" and arg_715_1.actors_[var_718_1.prefab_name] ~= nil then
						local var_718_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_1.prefab_name].transform, "story_v_out_322151", "322151167", "story_v_out_322151.awb")

						arg_715_1:RecordAudio("322151167", var_718_6)
						arg_715_1:RecordAudio("322151167", var_718_6)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_out_322151", "322151167", "story_v_out_322151.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_out_322151", "322151167", "story_v_out_322151.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_7 = math.max(var_718_0, arg_715_1.talkMaxDuration)

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_7 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - 0) / var_718_7

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= 0 + var_718_7 and arg_715_1.time_ < 0 + var_718_7 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {}

		arg_715_1:InitPlayNodeList()
	end,
	Play322151168 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 322151168
		arg_719_1.duration_ = 5

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play322151169(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			local var_722_0 = 0.05

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_1 = arg_719_1:FormatText(arg_719_1:GetWordFromCfg(322151168).content)

				arg_719_1.text_.text = var_722_1

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_3 = 2 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_1) / 2)

				if (2 <= 0 and var_722_0 or var_722_0 * (utf8.len(var_722_1) / 2)) > 0 and var_722_0 < var_722_3 then
					arg_719_1.talkMaxDuration = var_722_3

					if var_722_3 + 0 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_3 + 0
					end
				end

				arg_719_1.text_.text = var_722_1
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)
				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_4 = math.max(var_722_0, arg_719_1.talkMaxDuration)

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_4 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - 0) / var_722_4

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= 0 + var_722_4 and arg_719_1.time_ < 0 + var_722_4 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {}

		arg_719_1:InitPlayNodeList()
	end,
	Play322151169 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 322151169
		arg_723_1.duration_ = 6.57

		local var_723_0 = {
			zh = 3.7,
			ja = 6.566
		}
		local var_723_1 = manager.audio:GetLocalizationFlag()

		if var_723_0[var_723_1] ~= nil then
			arg_723_1.duration_ = var_723_0[var_723_1]
		end

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play322151170(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			local var_726_0 = 0.475

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				arg_723_1.leftNameTxt_.text = arg_723_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, false)
				arg_723_1.callingController_:SetSelectedState("normal")

				local var_726_1 = arg_723_1:GetWordFromCfg(322151169)
				local var_726_2 = arg_723_1:FormatText(var_726_1.content)

				arg_723_1.text_.text = var_726_2

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_4 = 19 <= 0 and var_726_0 or var_726_0 * (utf8.len(var_726_2) / 19)

				if (19 <= 0 and var_726_0 or var_726_0 * (utf8.len(var_726_2) / 19)) > 0 and var_726_0 < var_726_4 then
					arg_723_1.talkMaxDuration = var_726_4

					if var_726_4 + 0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_4 + 0
					end
				end

				arg_723_1.text_.text = var_726_2
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151169", "story_v_out_322151.awb") ~= 0 then
					local var_726_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151169", "story_v_out_322151.awb") / 1000

					if var_726_5 + 0 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_5 + 0
					end

					if var_726_1.prefab_name ~= "" and arg_723_1.actors_[var_726_1.prefab_name] ~= nil then
						local var_726_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_723_1.actors_[var_726_1.prefab_name].transform, "story_v_out_322151", "322151169", "story_v_out_322151.awb")

						arg_723_1:RecordAudio("322151169", var_726_6)
						arg_723_1:RecordAudio("322151169", var_726_6)
					else
						arg_723_1:AudioAction("play", "voice", "story_v_out_322151", "322151169", "story_v_out_322151.awb")
					end

					arg_723_1:RecordHistoryTalkVoice("story_v_out_322151", "322151169", "story_v_out_322151.awb")
				end

				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_7 = math.max(var_726_0, arg_723_1.talkMaxDuration)

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_7 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - 0) / var_726_7

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= 0 + var_726_7 and arg_723_1.time_ < 0 + var_726_7 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play322151170 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 322151170
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play322151171(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = 1.125

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, true)

				arg_727_1.leftNameTxt_.text = arg_727_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_727_1.leftNameTxt_.transform)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1.leftNameTxt_.text)
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_1 = arg_727_1:FormatText(arg_727_1:GetWordFromCfg(322151170).content)

				arg_727_1.text_.text = var_730_1

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_3 = 45 <= 0 and var_730_0 or var_730_0 * (utf8.len(var_730_1) / 45)

				if (45 <= 0 and var_730_0 or var_730_0 * (utf8.len(var_730_1) / 45)) > 0 and var_730_0 < var_730_3 then
					arg_727_1.talkMaxDuration = var_730_3

					if var_730_3 + 0 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_3 + 0
					end
				end

				arg_727_1.text_.text = var_730_1
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_4 = math.max(var_730_0, arg_727_1.talkMaxDuration)

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_4 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - 0) / var_730_4

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= 0 + var_730_4 and arg_727_1.time_ < 0 + var_730_4 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play322151171 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 322151171
		arg_731_1.duration_ = 9.7

		local var_731_0 = {
			zh = 5.866,
			ja = 9.7
		}
		local var_731_1 = manager.audio:GetLocalizationFlag()

		if var_731_0[var_731_1] ~= nil then
			arg_731_1.duration_ = var_731_0[var_731_1]
		end

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
		end

		function arg_731_1.playNext_(arg_733_0)
			if arg_733_0 == 1 then
				arg_731_0:Play322151172(arg_731_1)
			end
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			local var_734_0 = 0.725

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				arg_731_1.leftNameTxt_.text = arg_731_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_1 = arg_731_1:GetWordFromCfg(322151171)
				local var_734_2 = arg_731_1:FormatText(var_734_1.content)

				arg_731_1.text_.text = var_734_2

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_4 = 29 <= 0 and var_734_0 or var_734_0 * (utf8.len(var_734_2) / 29)

				if (29 <= 0 and var_734_0 or var_734_0 * (utf8.len(var_734_2) / 29)) > 0 and var_734_0 < var_734_4 then
					arg_731_1.talkMaxDuration = var_734_4

					if var_734_4 + 0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_4 + 0
					end
				end

				arg_731_1.text_.text = var_734_2
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151171", "story_v_out_322151.awb") ~= 0 then
					local var_734_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151171", "story_v_out_322151.awb") / 1000

					if var_734_5 + 0 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_5 + 0
					end

					if var_734_1.prefab_name ~= "" and arg_731_1.actors_[var_734_1.prefab_name] ~= nil then
						local var_734_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_731_1.actors_[var_734_1.prefab_name].transform, "story_v_out_322151", "322151171", "story_v_out_322151.awb")

						arg_731_1:RecordAudio("322151171", var_734_6)
						arg_731_1:RecordAudio("322151171", var_734_6)
					else
						arg_731_1:AudioAction("play", "voice", "story_v_out_322151", "322151171", "story_v_out_322151.awb")
					end

					arg_731_1:RecordHistoryTalkVoice("story_v_out_322151", "322151171", "story_v_out_322151.awb")
				end

				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_7 = math.max(var_734_0, arg_731_1.talkMaxDuration)

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_7 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - 0) / var_734_7

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= 0 + var_734_7 and arg_731_1.time_ < 0 + var_734_7 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {}

		arg_731_1:InitPlayNodeList()
	end,
	Play322151172 = function(arg_735_0, arg_735_1)
		arg_735_1.time_ = 0
		arg_735_1.frameCnt_ = 0
		arg_735_1.state_ = "playing"
		arg_735_1.curTalkId_ = 322151172
		arg_735_1.duration_ = 5

		SetActive(arg_735_1.tipsGo_, false)

		function arg_735_1.onSingleLineFinish_()
			arg_735_1.onSingleLineUpdate_ = nil
			arg_735_1.onSingleLineFinish_ = nil
			arg_735_1.state_ = "waiting"
		end

		function arg_735_1.playNext_(arg_737_0)
			if arg_737_0 == 1 then
				arg_735_0:Play322151173(arg_735_1)
			end
		end

		function arg_735_1.onSingleLineUpdate_(arg_738_0)
			local var_738_0 = 0.85

			if 0 < arg_735_1.time_ and arg_735_1.time_ <= 0 + arg_738_0 then
				arg_735_1.talkMaxDuration = 0
				arg_735_1.dialogCg_.alpha = 1

				arg_735_1.dialog_:SetActive(true)
				SetActive(arg_735_1.leftNameGo_, true)

				arg_735_1.leftNameTxt_.text = arg_735_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_735_1.leftNameTxt_.transform)

				arg_735_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_735_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_735_1:RecordName(arg_735_1.leftNameTxt_.text)
				SetActive(arg_735_1.iconTrs_.gameObject, false)
				arg_735_1.callingController_:SetSelectedState("normal")

				local var_738_1 = arg_735_1:FormatText(arg_735_1:GetWordFromCfg(322151172).content)

				arg_735_1.text_.text = var_738_1

				LuaForUtil.ClearLinePrefixSymbol(arg_735_1.text_)

				local var_738_3 = 34 <= 0 and var_738_0 or var_738_0 * (utf8.len(var_738_1) / 34)

				if (34 <= 0 and var_738_0 or var_738_0 * (utf8.len(var_738_1) / 34)) > 0 and var_738_0 < var_738_3 then
					arg_735_1.talkMaxDuration = var_738_3

					if var_738_3 + 0 > arg_735_1.duration_ then
						arg_735_1.duration_ = var_738_3 + 0
					end
				end

				arg_735_1.text_.text = var_738_1
				arg_735_1.typewritter.percent = 0

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(false)
				arg_735_1:RecordContent(arg_735_1.text_.text)
			end

			local var_738_4 = math.max(var_738_0, arg_735_1.talkMaxDuration)

			if 0 <= arg_735_1.time_ and arg_735_1.time_ < 0 + var_738_4 then
				arg_735_1.typewritter.percent = (arg_735_1.time_ - 0) / var_738_4

				arg_735_1.typewritter:SetDirty()
			end

			if arg_735_1.time_ >= 0 + var_738_4 and arg_735_1.time_ < 0 + var_738_4 + arg_738_0 then
				arg_735_1.typewritter.percent = 1

				arg_735_1.typewritter:SetDirty()
				arg_735_1:ShowNextGo(true)
			end
		end

		arg_735_1.nodeConfigList_ = {}

		arg_735_1:InitPlayNodeList()
	end,
	Play322151173 = function(arg_739_0, arg_739_1)
		arg_739_1.time_ = 0
		arg_739_1.frameCnt_ = 0
		arg_739_1.state_ = "playing"
		arg_739_1.curTalkId_ = 322151173
		arg_739_1.duration_ = 3.3

		SetActive(arg_739_1.tipsGo_, false)

		function arg_739_1.onSingleLineFinish_()
			arg_739_1.onSingleLineUpdate_ = nil
			arg_739_1.onSingleLineFinish_ = nil
			arg_739_1.state_ = "waiting"
		end

		function arg_739_1.playNext_(arg_741_0)
			if arg_741_0 == 1 then
				arg_739_0:Play322151174(arg_739_1)
			end
		end

		function arg_739_1.onSingleLineUpdate_(arg_742_0)
			local var_742_0 = 0.05

			if 0 < arg_739_1.time_ and arg_739_1.time_ <= 0 + arg_742_0 then
				arg_739_1.talkMaxDuration = 0
				arg_739_1.dialogCg_.alpha = 1

				arg_739_1.dialog_:SetActive(true)
				SetActive(arg_739_1.leftNameGo_, true)

				arg_739_1.leftNameTxt_.text = arg_739_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_739_1.leftNameTxt_.transform)

				arg_739_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_739_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_739_1:RecordName(arg_739_1.leftNameTxt_.text)
				SetActive(arg_739_1.iconTrs_.gameObject, false)
				arg_739_1.callingController_:SetSelectedState("normal")

				local var_742_1 = arg_739_1:GetWordFromCfg(322151173)
				local var_742_2 = arg_739_1:FormatText(var_742_1.content)

				arg_739_1.text_.text = var_742_2

				LuaForUtil.ClearLinePrefixSymbol(arg_739_1.text_)

				local var_742_4 = 2 <= 0 and var_742_0 or var_742_0 * (utf8.len(var_742_2) / 2)

				if (2 <= 0 and var_742_0 or var_742_0 * (utf8.len(var_742_2) / 2)) > 0 and var_742_0 < var_742_4 then
					arg_739_1.talkMaxDuration = var_742_4

					if var_742_4 + 0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_4 + 0
					end
				end

				arg_739_1.text_.text = var_742_2
				arg_739_1.typewritter.percent = 0

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322151", "322151173", "story_v_out_322151.awb") ~= 0 then
					local var_742_5 = manager.audio:GetVoiceLength("story_v_out_322151", "322151173", "story_v_out_322151.awb") / 1000

					if var_742_5 + 0 > arg_739_1.duration_ then
						arg_739_1.duration_ = var_742_5 + 0
					end

					if var_742_1.prefab_name ~= "" and arg_739_1.actors_[var_742_1.prefab_name] ~= nil then
						local var_742_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_739_1.actors_[var_742_1.prefab_name].transform, "story_v_out_322151", "322151173", "story_v_out_322151.awb")

						arg_739_1:RecordAudio("322151173", var_742_6)
						arg_739_1:RecordAudio("322151173", var_742_6)
					else
						arg_739_1:AudioAction("play", "voice", "story_v_out_322151", "322151173", "story_v_out_322151.awb")
					end

					arg_739_1:RecordHistoryTalkVoice("story_v_out_322151", "322151173", "story_v_out_322151.awb")
				end

				arg_739_1:RecordContent(arg_739_1.text_.text)
			end

			local var_742_7 = math.max(var_742_0, arg_739_1.talkMaxDuration)

			if 0 <= arg_739_1.time_ and arg_739_1.time_ < 0 + var_742_7 then
				arg_739_1.typewritter.percent = (arg_739_1.time_ - 0) / var_742_7

				arg_739_1.typewritter:SetDirty()
			end

			if arg_739_1.time_ >= 0 + var_742_7 and arg_739_1.time_ < 0 + var_742_7 + arg_742_0 then
				arg_739_1.typewritter.percent = 1

				arg_739_1.typewritter:SetDirty()
				arg_739_1:ShowNextGo(true)
			end
		end

		arg_739_1.nodeConfigList_ = {}

		arg_739_1:InitPlayNodeList()
	end,
	Play322151174 = function(arg_743_0, arg_743_1)
		arg_743_1.time_ = 0
		arg_743_1.frameCnt_ = 0
		arg_743_1.state_ = "playing"
		arg_743_1.curTalkId_ = 322151174
		arg_743_1.duration_ = 5

		SetActive(arg_743_1.tipsGo_, false)

		function arg_743_1.onSingleLineFinish_()
			arg_743_1.onSingleLineUpdate_ = nil
			arg_743_1.onSingleLineFinish_ = nil
			arg_743_1.state_ = "waiting"
			arg_743_1.auto_ = false
		end

		function arg_743_1.playNext_(arg_745_0)
			arg_743_1.onStoryFinished_()
		end

		function arg_743_1.onSingleLineUpdate_(arg_746_0)
			local var_746_0 = 0.475

			if 0 < arg_743_1.time_ and arg_743_1.time_ <= 0 + arg_746_0 then
				arg_743_1.talkMaxDuration = 0
				arg_743_1.dialogCg_.alpha = 1

				arg_743_1.dialog_:SetActive(true)
				SetActive(arg_743_1.leftNameGo_, true)

				arg_743_1.leftNameTxt_.text = arg_743_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_743_1.leftNameTxt_.transform)

				arg_743_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_743_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_743_1:RecordName(arg_743_1.leftNameTxt_.text)
				SetActive(arg_743_1.iconTrs_.gameObject, false)
				arg_743_1.callingController_:SetSelectedState("normal")

				local var_746_1 = arg_743_1:FormatText(arg_743_1:GetWordFromCfg(322151174).content)

				arg_743_1.text_.text = var_746_1

				LuaForUtil.ClearLinePrefixSymbol(arg_743_1.text_)

				local var_746_3 = 19 <= 0 and var_746_0 or var_746_0 * (utf8.len(var_746_1) / 19)

				if (19 <= 0 and var_746_0 or var_746_0 * (utf8.len(var_746_1) / 19)) > 0 and var_746_0 < var_746_3 then
					arg_743_1.talkMaxDuration = var_746_3

					if var_746_3 + 0 > arg_743_1.duration_ then
						arg_743_1.duration_ = var_746_3 + 0
					end
				end

				arg_743_1.text_.text = var_746_1
				arg_743_1.typewritter.percent = 0

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(false)
				arg_743_1:RecordContent(arg_743_1.text_.text)
			end

			local var_746_4 = math.max(var_746_0, arg_743_1.talkMaxDuration)

			if 0 <= arg_743_1.time_ and arg_743_1.time_ < 0 + var_746_4 then
				arg_743_1.typewritter.percent = (arg_743_1.time_ - 0) / var_746_4

				arg_743_1.typewritter:SetDirty()
			end

			if arg_743_1.time_ >= 0 + var_746_4 and arg_743_1.time_ < 0 + var_746_4 + arg_746_0 then
				arg_743_1.typewritter.percent = 1

				arg_743_1.typewritter:SetDirty()
				arg_743_1:ShowNextGo(true)
			end
		end

		arg_743_1.nodeConfigList_ = {}

		arg_743_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/ST0502",
		"TextureConfig/Background/ST0510",
		"TextureConfig/Background/MS2209",
		"TextureConfig/Background/ST0504",
		"TextureConfig/Background/MS2209a",
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/L08f",
		"TextureConfig/Background/ST0507a"
	},
	voices = {
		"story_v_out_322151.awb"
	}
}
