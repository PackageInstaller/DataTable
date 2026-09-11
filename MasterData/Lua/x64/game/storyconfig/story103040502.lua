return {
	Play304052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 304052001
		arg_1_1.duration_ = 7.14

		local var_1_0 = {
			zh = 7.141,
			ja = 6.975
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
				arg_1_0:Play304052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B04a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B04a")
				var_4_0.name = "B04a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B04a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B04a

				arg_1_1.bgs_.B04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1148ui_story"

			if arg_1_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1148ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 1.375
			local var_4_22 = 0.625

			if 1.375 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_24 = arg_1_1:GetWordFromCfg(304052001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 25 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 25)

				if (25 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 25)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052001", "story_v_out_304052.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_304052", "304052001", "story_v_out_304052.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_304052", "304052001", "story_v_out_304052.awb")

						arg_1_1:RecordAudio("304052001", var_4_29)
						arg_1_1:RecordAudio("304052001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_304052", "304052001", "story_v_out_304052.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_304052", "304052001", "story_v_out_304052.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play304052002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 304052002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play304052003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = arg_8_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) then
				if arg_8_1.var_.characterEffect1148ui_story and not isNil(arg_8_1.actors_["1148ui_story"]) then
					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1148ui_story"]) and arg_8_1.var_.characterEffect1148ui_story then
				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 1.1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(304052002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 44 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 44)

				if (44 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 44)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play304052003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 304052003
		arg_12_1.duration_ = 4.37

		local var_12_0 = {
			zh = 4.366,
			ja = 4.233
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play304052004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1059ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1059ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1059ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1059ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1059ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1059ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1059ui_story, Vector3.New(-0.7, -1.05, -6), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(-0.7, -1.05, -6)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = arg_12_1.actors_["1059ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1059ui_story == nil then
				arg_12_1.var_.characterEffect1059ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1059ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1059ui_story then
				arg_12_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_15_8 = 0
			local var_15_9 = 0.4

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(304052003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 16 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 16)

				if (16 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 16)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052003", "story_v_out_304052.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_304052", "304052003", "story_v_out_304052.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_304052", "304052003", "story_v_out_304052.awb")

						arg_12_1:RecordAudio("304052003", var_15_15)
						arg_12_1:RecordAudio("304052003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_304052", "304052003", "story_v_out_304052.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_304052", "304052003", "story_v_out_304052.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play304052004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 304052004
		arg_16_1.duration_ = 8

		local var_16_0 = {
			zh = 6.066,
			ja = 8
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
				arg_16_0:Play304052005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1148ui_story = arg_16_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).z)
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles = arg_16_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0.7, -0.8, -6.2)
				arg_16_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1148ui_story"].transform.position).z)
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1148ui_story"].transform.localEulerAngles = arg_16_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1148ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1148ui_story == nil then
				arg_16_1.var_.characterEffect1148ui_story = var_19_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 and not isNil(var_19_1) then
				if arg_16_1.var_.characterEffect1148ui_story and not isNil(var_19_1) then
					arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1148ui_story then
				arg_16_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1059ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1059ui_story == nil then
				arg_16_1.var_.characterEffect1059ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_5 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 and not isNil(var_19_4) then
				if arg_16_1.var_.characterEffect1059ui_story and not isNil(var_19_4) then
					arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_5)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1059ui_story then
				arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action4_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_19_6 = 0
			local var_19_7 = 0.65

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_8 = arg_16_1:GetWordFromCfg(304052004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 26 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 26)

				if (26 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 26)) > 0 and var_19_7 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052004", "story_v_out_304052.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_304052", "304052004", "story_v_out_304052.awb") / 1000

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end

					if var_19_8.prefab_name ~= "" and arg_16_1.actors_[var_19_8.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_8.prefab_name].transform, "story_v_out_304052", "304052004", "story_v_out_304052.awb")

						arg_16_1:RecordAudio("304052004", var_19_13)
						arg_16_1:RecordAudio("304052004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_304052", "304052004", "story_v_out_304052.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_304052", "304052004", "story_v_out_304052.awb")
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
				actorName = "1148ui_story",
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
	Play304052005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 304052005
		arg_20_1.duration_ = 5.73

		local var_20_0 = {
			zh = 5.533,
			ja = 5.733
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
				arg_20_0:Play304052006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1059ui_story"]) and arg_20_1.var_.characterEffect1059ui_story == nil then
				arg_20_1.var_.characterEffect1059ui_story = arg_20_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1059ui_story"]) then
				if arg_20_1.var_.characterEffect1059ui_story and not isNil(arg_20_1.actors_["1059ui_story"]) then
					arg_20_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1059ui_story"]) and arg_20_1.var_.characterEffect1059ui_story then
				arg_20_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1148ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1148ui_story == nil then
				arg_20_1.var_.characterEffect1148ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1148ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1148ui_story then
				arg_20_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_23_4 = 0
			local var_23_5 = 0.6

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(304052005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 24 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 24)

				if (24 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 24)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052005", "story_v_out_304052.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052005", "story_v_out_304052.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_304052", "304052005", "story_v_out_304052.awb")

						arg_20_1:RecordAudio("304052005", var_23_11)
						arg_20_1:RecordAudio("304052005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_304052", "304052005", "story_v_out_304052.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_304052", "304052005", "story_v_out_304052.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play304052006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 304052006
		arg_24_1.duration_ = 14.6

		local var_24_0 = {
			zh = 8.666,
			ja = 14.6
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
				arg_24_0:Play304052007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_2")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_0 = 0
			local var_27_1 = 1.125

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_2 = arg_24_1:GetWordFromCfg(304052006)
				local var_27_3 = arg_24_1:FormatText(var_27_2.content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 45 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 45)

				if (45 <= 0 and var_27_1 or var_27_1 * (utf8.len(var_27_3) / 45)) > 0 and var_27_1 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052006", "story_v_out_304052.awb") ~= 0 then
					local var_27_6 = manager.audio:GetVoiceLength("story_v_out_304052", "304052006", "story_v_out_304052.awb") / 1000

					if var_27_6 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_0
					end

					if var_27_2.prefab_name ~= "" and arg_24_1.actors_[var_27_2.prefab_name] ~= nil then
						local var_27_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_2.prefab_name].transform, "story_v_out_304052", "304052006", "story_v_out_304052.awb")

						arg_24_1:RecordAudio("304052006", var_27_7)
						arg_24_1:RecordAudio("304052006", var_27_7)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_304052", "304052006", "story_v_out_304052.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_304052", "304052006", "story_v_out_304052.awb")
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
	Play304052007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 304052007
		arg_28_1.duration_ = 6.03

		local var_28_0 = {
			zh = 4.9,
			ja = 6.033
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
				arg_28_0:Play304052008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) and arg_28_1.var_.characterEffect1148ui_story == nil then
				arg_28_1.var_.characterEffect1148ui_story = arg_28_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) then
				if arg_28_1.var_.characterEffect1148ui_story and not isNil(arg_28_1.actors_["1148ui_story"]) then
					arg_28_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1148ui_story"]) and arg_28_1.var_.characterEffect1148ui_story then
				arg_28_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["1059ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1059ui_story == nil then
				arg_28_1.var_.characterEffect1059ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect1059ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect1059ui_story then
				arg_28_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action447")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_4 = 0
			local var_31_5 = 0.5

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(304052007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 20 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 20)

				if (20 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 20)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052007", "story_v_out_304052.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052007", "story_v_out_304052.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_304052", "304052007", "story_v_out_304052.awb")

						arg_28_1:RecordAudio("304052007", var_31_11)
						arg_28_1:RecordAudio("304052007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_304052", "304052007", "story_v_out_304052.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_304052", "304052007", "story_v_out_304052.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play304052008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 304052008
		arg_32_1.duration_ = 9.63

		local var_32_0 = {
			zh = 6.566,
			ja = 9.633
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
				arg_32_0:Play304052009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1059ui_story"]) and arg_32_1.var_.characterEffect1059ui_story == nil then
				arg_32_1.var_.characterEffect1059ui_story = arg_32_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1059ui_story"]) then
				if arg_32_1.var_.characterEffect1059ui_story and not isNil(arg_32_1.actors_["1059ui_story"]) then
					arg_32_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1059ui_story"]) and arg_32_1.var_.characterEffect1059ui_story then
				arg_32_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1148ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1148ui_story == nil then
				arg_32_1.var_.characterEffect1148ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect1148ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect1148ui_story then
				arg_32_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_35_4 = 0
			local var_35_5 = 0.75

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(304052008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 30 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 30)

				if (30 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 30)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052008", "story_v_out_304052.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052008", "story_v_out_304052.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_304052", "304052008", "story_v_out_304052.awb")

						arg_32_1:RecordAudio("304052008", var_35_11)
						arg_32_1:RecordAudio("304052008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_304052", "304052008", "story_v_out_304052.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_304052", "304052008", "story_v_out_304052.awb")
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

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play304052009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 304052009
		arg_36_1.duration_ = 5.6

		local var_36_0 = {
			zh = 4.833,
			ja = 5.6
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
				arg_36_0:Play304052010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.7

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(304052009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 28 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 28)

				if (28 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 28)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052009", "story_v_out_304052.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052009", "story_v_out_304052.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_304052", "304052009", "story_v_out_304052.awb")

						arg_36_1:RecordAudio("304052009", var_39_6)
						arg_36_1:RecordAudio("304052009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_304052", "304052009", "story_v_out_304052.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_304052", "304052009", "story_v_out_304052.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play304052010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 304052010
		arg_40_1.duration_ = 5.2

		local var_40_0 = {
			zh = 5.2,
			ja = 5.1
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
				arg_40_0:Play304052011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) and arg_40_1.var_.characterEffect1148ui_story == nil then
				arg_40_1.var_.characterEffect1148ui_story = arg_40_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) then
				if arg_40_1.var_.characterEffect1148ui_story and not isNil(arg_40_1.actors_["1148ui_story"]) then
					arg_40_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1148ui_story"]) and arg_40_1.var_.characterEffect1148ui_story then
				arg_40_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1059ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1059ui_story == nil then
				arg_40_1.var_.characterEffect1059ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1059ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1059ui_story then
				arg_40_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action7_2")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_4 = 0
			local var_43_5 = 0.575

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(304052010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 23 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 23)

				if (23 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 23)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052010", "story_v_out_304052.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052010", "story_v_out_304052.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_304052", "304052010", "story_v_out_304052.awb")

						arg_40_1:RecordAudio("304052010", var_43_11)
						arg_40_1:RecordAudio("304052010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_304052", "304052010", "story_v_out_304052.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_304052", "304052010", "story_v_out_304052.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play304052011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 304052011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play304052012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1148ui_story"]) and arg_44_1.var_.characterEffect1148ui_story == nil then
				arg_44_1.var_.characterEffect1148ui_story = arg_44_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1148ui_story"]) then
				if arg_44_1.var_.characterEffect1148ui_story and not isNil(arg_44_1.actors_["1148ui_story"]) then
					arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1148ui_story"]) and arg_44_1.var_.characterEffect1148ui_story then
				arg_44_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 1.375

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_3 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(304052011).content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 55 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 55)

				if (55 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_3) / 55)) > 0 and var_47_2 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_6 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_6 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_6

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_6 and arg_44_1.time_ < var_47_1 + var_47_6 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play304052012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 304052012
		arg_48_1.duration_ = 3.43

		local var_48_0 = {
			zh = 2.4,
			ja = 3.433
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
				arg_48_0:Play304052013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1059ui_story"]) and arg_48_1.var_.characterEffect1059ui_story == nil then
				arg_48_1.var_.characterEffect1059ui_story = arg_48_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1059ui_story"]) then
				if arg_48_1.var_.characterEffect1059ui_story and not isNil(arg_48_1.actors_["1059ui_story"]) then
					arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1059ui_story"]) and arg_48_1.var_.characterEffect1059ui_story then
				arg_48_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_2 = 0
			local var_51_3 = 0.275

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(304052012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 11 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 11)

				if (11 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 11)) > 0 and var_51_3 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052012", "story_v_out_304052.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_304052", "304052012", "story_v_out_304052.awb") / 1000

					if var_51_8 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_2
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_304052", "304052012", "story_v_out_304052.awb")

						arg_48_1:RecordAudio("304052012", var_51_9)
						arg_48_1:RecordAudio("304052012", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_304052", "304052012", "story_v_out_304052.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_304052", "304052012", "story_v_out_304052.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_10 and arg_48_1.time_ < var_51_2 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play304052013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 304052013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play304052014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1059ui_story"]) and arg_52_1.var_.characterEffect1059ui_story == nil then
				arg_52_1.var_.characterEffect1059ui_story = arg_52_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1059ui_story"]) then
				if arg_52_1.var_.characterEffect1059ui_story and not isNil(arg_52_1.actors_["1059ui_story"]) then
					arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1059ui_story"]) and arg_52_1.var_.characterEffect1059ui_story then
				arg_52_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.925

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("calling")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(304052013).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 37 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 37)

				if (37 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 37)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play304052014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 304052014
		arg_56_1.duration_ = 11.13

		local var_56_0 = {
			zh = 7.533,
			ja = 11.133
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play304052015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1059ui_story"]) and arg_56_1.var_.characterEffect1059ui_story == nil then
				arg_56_1.var_.characterEffect1059ui_story = arg_56_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1059ui_story"]) then
				if arg_56_1.var_.characterEffect1059ui_story and not isNil(arg_56_1.actors_["1059ui_story"]) then
					arg_56_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1059ui_story"]) and arg_56_1.var_.characterEffect1059ui_story then
				arg_56_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_2 = 0
			local var_59_3 = 0.95

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(304052014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 38 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 38)

				if (38 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 38)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052014", "story_v_out_304052.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_304052", "304052014", "story_v_out_304052.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_304052", "304052014", "story_v_out_304052.awb")

						arg_56_1:RecordAudio("304052014", var_59_9)
						arg_56_1:RecordAudio("304052014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_304052", "304052014", "story_v_out_304052.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_304052", "304052014", "story_v_out_304052.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_10 and arg_56_1.time_ < var_59_2 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play304052015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 304052015
		arg_60_1.duration_ = 9.23

		local var_60_0 = {
			zh = 5.6,
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
				arg_60_0:Play304052016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) and arg_60_1.var_.characterEffect1148ui_story == nil then
				arg_60_1.var_.characterEffect1148ui_story = arg_60_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) then
				if arg_60_1.var_.characterEffect1148ui_story and not isNil(arg_60_1.actors_["1148ui_story"]) then
					arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1148ui_story"]) and arg_60_1.var_.characterEffect1148ui_story then
				arg_60_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1059ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1059ui_story == nil then
				arg_60_1.var_.characterEffect1059ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1059ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1059ui_story then
				arg_60_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_4 = 0
			local var_63_5 = 0.625

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(304052015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 25 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 25)

				if (25 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 25)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052015", "story_v_out_304052.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052015", "story_v_out_304052.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_304052", "304052015", "story_v_out_304052.awb")

						arg_60_1:RecordAudio("304052015", var_63_11)
						arg_60_1:RecordAudio("304052015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_304052", "304052015", "story_v_out_304052.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_304052", "304052015", "story_v_out_304052.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play304052016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 304052016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play304052017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1148ui_story"]) and arg_64_1.var_.characterEffect1148ui_story == nil then
				arg_64_1.var_.characterEffect1148ui_story = arg_64_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1148ui_story"]) then
				if arg_64_1.var_.characterEffect1148ui_story and not isNil(arg_64_1.actors_["1148ui_story"]) then
					arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1148ui_story"]) and arg_64_1.var_.characterEffect1148ui_story then
				arg_64_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.125

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("calling")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(304052016).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 5 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 5)

				if (5 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 5)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play304052017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 304052017
		arg_68_1.duration_ = 11.7

		local var_68_0 = {
			zh = 9.4,
			ja = 11.7
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
				arg_68_0:Play304052018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1059ui_story"]) and arg_68_1.var_.characterEffect1059ui_story == nil then
				arg_68_1.var_.characterEffect1059ui_story = arg_68_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1059ui_story"]) then
				if arg_68_1.var_.characterEffect1059ui_story and not isNil(arg_68_1.actors_["1059ui_story"]) then
					arg_68_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1059ui_story"]) and arg_68_1.var_.characterEffect1059ui_story then
				arg_68_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_71_2 = 0
			local var_71_3 = 1.3

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(304052017)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 52 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 52)

				if (52 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 52)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052017", "story_v_out_304052.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_304052", "304052017", "story_v_out_304052.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_304052", "304052017", "story_v_out_304052.awb")

						arg_68_1:RecordAudio("304052017", var_71_9)
						arg_68_1:RecordAudio("304052017", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_304052", "304052017", "story_v_out_304052.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_304052", "304052017", "story_v_out_304052.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play304052018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 304052018
		arg_72_1.duration_ = 8.7

		local var_72_0 = {
			zh = 5.4,
			ja = 8.7
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
				arg_72_0:Play304052019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_2")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_0 = 0
			local var_75_1 = 0.75

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(304052018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 30 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 30)

				if (30 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 30)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052018", "story_v_out_304052.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_out_304052", "304052018", "story_v_out_304052.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_out_304052", "304052018", "story_v_out_304052.awb")

						arg_72_1:RecordAudio("304052018", var_75_7)
						arg_72_1:RecordAudio("304052018", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_304052", "304052018", "story_v_out_304052.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_304052", "304052018", "story_v_out_304052.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play304052019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 304052019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play304052020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) and arg_76_1.var_.characterEffect1059ui_story == nil then
				arg_76_1.var_.characterEffect1059ui_story = arg_76_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) then
				if arg_76_1.var_.characterEffect1059ui_story and not isNil(arg_76_1.actors_["1059ui_story"]) then
					arg_76_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_0)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1059ui_story"]) and arg_76_1.var_.characterEffect1059ui_story then
				arg_76_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_79_1 = 0
			local var_79_2 = 0.525

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_76_1.callingController_:SetSelectedState("calling")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(304052019).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 21 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 21)

				if (21 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 21)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_6 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_6 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_6

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_6 and arg_76_1.time_ < var_79_1 + var_79_6 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play304052020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 304052020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play304052021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 1.175

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("calling")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(304052020).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 47 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 47)

				if (47 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 47)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play304052021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 304052021
		arg_84_1.duration_ = 7.9

		local var_84_0 = {
			zh = 5.566,
			ja = 7.9
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
				arg_84_0:Play304052022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1148ui_story"]) and arg_84_1.var_.characterEffect1148ui_story == nil then
				arg_84_1.var_.characterEffect1148ui_story = arg_84_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1148ui_story"]) then
				if arg_84_1.var_.characterEffect1148ui_story and not isNil(arg_84_1.actors_["1148ui_story"]) then
					arg_84_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1148ui_story"]) and arg_84_1.var_.characterEffect1148ui_story then
				arg_84_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action453")
			end

			local var_87_2 = 0
			local var_87_3 = 0.5

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(304052021)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 20 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 20)

				if (20 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_5) / 20)) > 0 and var_87_3 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052021", "story_v_out_304052.awb") ~= 0 then
					local var_87_8 = manager.audio:GetVoiceLength("story_v_out_304052", "304052021", "story_v_out_304052.awb") / 1000

					if var_87_8 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_2
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_304052", "304052021", "story_v_out_304052.awb")

						arg_84_1:RecordAudio("304052021", var_87_9)
						arg_84_1:RecordAudio("304052021", var_87_9)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_304052", "304052021", "story_v_out_304052.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_304052", "304052021", "story_v_out_304052.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_10 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_10 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_10

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_10 and arg_84_1.time_ < var_87_2 + var_87_10 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play304052022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 304052022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play304052023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1148ui_story"]) and arg_88_1.var_.characterEffect1148ui_story == nil then
				arg_88_1.var_.characterEffect1148ui_story = arg_88_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1148ui_story"]) then
				if arg_88_1.var_.characterEffect1148ui_story and not isNil(arg_88_1.actors_["1148ui_story"]) then
					arg_88_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1148ui_story"]) and arg_88_1.var_.characterEffect1148ui_story then
				arg_88_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.075

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("calling")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(304052022).content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 3 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 3)

				if (3 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 3)) > 0 and var_91_2 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_6 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_6 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_6

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_6 and arg_88_1.time_ < var_91_1 + var_91_6 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play304052023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 304052023
		arg_92_1.duration_ = 1

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"

			SetActive(arg_92_1.choicesGo_, true)

			for iter_93_0, iter_93_1 in ipairs(arg_92_1.choices_) do
				SetActive(iter_93_1.go, iter_93_0 <= 2)
			end

			arg_92_1.choices_[1].txt.text = arg_92_1:FormatText(StoryChoiceCfg[1766].name)
			arg_92_1.choices_[2].txt.text = arg_92_1:FormatText(StoryChoiceCfg[1767].name)
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play304052024(arg_92_1)
			end

			if arg_94_0 == 2 then
				arg_92_0:Play304052028(arg_92_1)
			end

			arg_92_1:RecordChoiceLog(304052023, 1766, 1767)
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			return
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play304052024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 304052024
		arg_96_1.duration_ = 4.43

		local var_96_0 = {
			zh = 4.433,
			ja = 4.033
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play304052025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1148ui_story"]) and arg_96_1.var_.characterEffect1148ui_story == nil then
				arg_96_1.var_.characterEffect1148ui_story = arg_96_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1148ui_story"]) then
				if arg_96_1.var_.characterEffect1148ui_story and not isNil(arg_96_1.actors_["1148ui_story"]) then
					arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1148ui_story"]) and arg_96_1.var_.characterEffect1148ui_story then
				arg_96_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_2 = 0
			local var_99_3 = 0.475

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(304052024)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 19 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 19)

				if (19 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 19)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052024", "story_v_out_304052.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_304052", "304052024", "story_v_out_304052.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_304052", "304052024", "story_v_out_304052.awb")

						arg_96_1:RecordAudio("304052024", var_99_9)
						arg_96_1:RecordAudio("304052024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_304052", "304052024", "story_v_out_304052.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_304052", "304052024", "story_v_out_304052.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play304052025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 304052025
		arg_100_1.duration_ = 4.97

		local var_100_0 = {
			zh = 4.966,
			ja = 3.666
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
				arg_100_0:Play304052026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.625

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:GetWordFromCfg(304052025)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 25 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 25)

				if (25 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 25)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052025", "story_v_out_304052.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052025", "story_v_out_304052.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_304052", "304052025", "story_v_out_304052.awb")

						arg_100_1:RecordAudio("304052025", var_103_6)
						arg_100_1:RecordAudio("304052025", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_304052", "304052025", "story_v_out_304052.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_304052", "304052025", "story_v_out_304052.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play304052026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 304052026
		arg_104_1.duration_ = 5

		local var_104_0 = {
			zh = 3.4,
			ja = 5
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
				arg_104_0:Play304052027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1059ui_story"]) and arg_104_1.var_.characterEffect1059ui_story == nil then
				arg_104_1.var_.characterEffect1059ui_story = arg_104_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1059ui_story"]) then
				if arg_104_1.var_.characterEffect1059ui_story and not isNil(arg_104_1.actors_["1059ui_story"]) then
					arg_104_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1059ui_story"]) and arg_104_1.var_.characterEffect1059ui_story then
				arg_104_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["1148ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1148ui_story == nil then
				arg_104_1.var_.characterEffect1148ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect1148ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1148ui_story then
				arg_104_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			local var_107_4 = 0
			local var_107_5 = 0.475

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(304052026)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 19 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 19)

				if (19 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 19)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052026", "story_v_out_304052.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052026", "story_v_out_304052.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_304052", "304052026", "story_v_out_304052.awb")

						arg_104_1:RecordAudio("304052026", var_107_11)
						arg_104_1:RecordAudio("304052026", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_304052", "304052026", "story_v_out_304052.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_304052", "304052026", "story_v_out_304052.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play304052027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 304052027
		arg_108_1.duration_ = 6.33

		local var_108_0 = {
			zh = 5.833,
			ja = 6.333
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
				arg_108_0:Play304052033(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) and arg_108_1.var_.characterEffect1148ui_story == nil then
				arg_108_1.var_.characterEffect1148ui_story = arg_108_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) then
				if arg_108_1.var_.characterEffect1148ui_story and not isNil(arg_108_1.actors_["1148ui_story"]) then
					arg_108_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1148ui_story"]) and arg_108_1.var_.characterEffect1148ui_story then
				arg_108_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_111_2 = arg_108_1.actors_["1059ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1059ui_story == nil then
				arg_108_1.var_.characterEffect1059ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_3 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.characterEffect1059ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_3)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect1059ui_story then
				arg_108_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action6_1")
			end

			local var_111_4 = 0
			local var_111_5 = 0.7

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(304052027)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 28 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 28)

				if (28 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 28)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052027", "story_v_out_304052.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052027", "story_v_out_304052.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_304052", "304052027", "story_v_out_304052.awb")

						arg_108_1:RecordAudio("304052027", var_111_11)
						arg_108_1:RecordAudio("304052027", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_304052", "304052027", "story_v_out_304052.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_304052", "304052027", "story_v_out_304052.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play304052033 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 304052033
		arg_112_1.duration_ = 7.9

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play304052034(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if arg_112_1.bgs_.A00 == nil then
				local var_115_0 = Object.Instantiate(arg_112_1.paintGo_)

				var_115_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_115_0.name = "A00"
				var_115_0.transform.parent = arg_112_1.stage_.transform
				var_115_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.bgs_.A00 = var_115_0
			end

			if 1.36666666666667 < arg_112_1.time_ and arg_112_1.time_ <= 1.36666666666667 + arg_115_0 then
				local var_115_1 = arg_112_1.bgs_.A00

				arg_112_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_115_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_115_2 = var_115_1:GetComponent("SpriteRenderer")

				if var_115_2 and var_115_2.sprite then
					local var_115_3 = 2 * (var_115_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_115_1.transform.localScale = Vector3.New(var_115_3 / var_115_2.sprite.bounds.size.y < var_115_3 * manager.ui.mainCameraCom_.aspect / var_115_2.sprite.bounds.size.x and var_115_3 * manager.ui.mainCameraCom_.aspect / var_115_2.sprite.bounds.size.x or var_115_3 / var_115_2.sprite.bounds.size.y, var_115_3 / var_115_2.sprite.bounds.size.y < var_115_3 * manager.ui.mainCameraCom_.aspect / var_115_2.sprite.bounds.size.x and var_115_3 * manager.ui.mainCameraCom_.aspect / var_115_2.sprite.bounds.size.x or var_115_3 / var_115_2.sprite.bounds.size.y, 0)
				end

				for iter_115_0, iter_115_1 in pairs(arg_112_1.bgs_) do
					if iter_115_0 ~= "A00" then
						iter_115_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_115_4 = 1.36666666666667

			if 1.36666666666667 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.allBtn_.enabled = false
			end

			if arg_112_1.time_ >= var_115_4 + 0.3 and arg_112_1.time_ < var_115_4 + 0.3 + arg_115_0 then
				arg_112_1.allBtn_.enabled = true
			end

			local var_115_5 = 0

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_6 = 1.40066666851441

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_6 then
				local var_115_7 = Color.New(0, 0, 0)

				var_115_7.a = Mathf.Lerp(0, 1, (arg_112_1.time_ - var_115_5) / var_115_6)
				arg_112_1.mask_.color = var_115_7
			end

			if arg_112_1.time_ >= var_115_5 + var_115_6 and arg_112_1.time_ < var_115_5 + var_115_6 + arg_115_0 then
				local var_115_8 = Color.New(0, 0, 0)

				var_115_8.a = 1
				arg_112_1.mask_.color = var_115_8
			end

			local var_115_9 = 1.36666666666667

			if 1.36666666666667 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_10 = 2

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_10 then
				local var_115_11 = Color.New(0, 0, 0)

				var_115_11.a = Mathf.Lerp(1, 0, (arg_112_1.time_ - var_115_9) / var_115_10)
				arg_112_1.mask_.color = var_115_11
			end

			if arg_112_1.time_ >= var_115_9 + var_115_10 and arg_112_1.time_ < var_115_9 + var_115_10 + arg_115_0 then
				local var_115_12 = Color.New(0, 0, 0)

				arg_112_1.mask_.enabled = false
				var_115_12.a = 0
				arg_112_1.mask_.color = var_115_12
			end

			local var_115_13 = arg_112_1.actors_["1148ui_story"].transform

			if 1.36666666666667 < arg_112_1.time_ and arg_112_1.time_ <= 1.36666666666667 + arg_115_0 then
				arg_112_1.var_.moveOldPos1148ui_story = var_115_13.localPosition
			end

			local var_115_14 = 0.001

			if 1.36666666666667 <= arg_112_1.time_ and arg_112_1.time_ < 1.36666666666667 + var_115_14 then
				var_115_13.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 1.36666666666667) / var_115_14)
				var_115_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_13.position).x, (manager.ui.mainCamera.transform.position - var_115_13.position).y, (manager.ui.mainCamera.transform.position - var_115_13.position).z)
				var_115_13.localEulerAngles.z = 0
				var_115_13.localEulerAngles.x = 0
				var_115_13.localEulerAngles = var_115_13.localEulerAngles
			end

			if arg_112_1.time_ >= 1.36666666666667 + var_115_14 and arg_112_1.time_ < 1.36666666666667 + var_115_14 + arg_115_0 then
				var_115_13.localPosition = Vector3.New(0, 100, 0)
				var_115_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_13.position).x, (manager.ui.mainCamera.transform.position - var_115_13.position).y, (manager.ui.mainCamera.transform.position - var_115_13.position).z)
				var_115_13.localEulerAngles.z = 0
				var_115_13.localEulerAngles.x = 0
				var_115_13.localEulerAngles = var_115_13.localEulerAngles
			end

			local var_115_15 = arg_112_1.actors_["1059ui_story"].transform

			if 1.36666666666667 < arg_112_1.time_ and arg_112_1.time_ <= 1.36666666666667 + arg_115_0 then
				arg_112_1.var_.moveOldPos1059ui_story = var_115_15.localPosition
			end

			local var_115_16 = 0.001

			if 1.36666666666667 <= arg_112_1.time_ and arg_112_1.time_ < 1.36666666666667 + var_115_16 then
				var_115_15.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 1.36666666666667) / var_115_16)
				var_115_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_15.position).x, (manager.ui.mainCamera.transform.position - var_115_15.position).y, (manager.ui.mainCamera.transform.position - var_115_15.position).z)
				var_115_15.localEulerAngles.z = 0
				var_115_15.localEulerAngles.x = 0
				var_115_15.localEulerAngles = var_115_15.localEulerAngles
			end

			if arg_112_1.time_ >= 1.36666666666667 + var_115_16 and arg_112_1.time_ < 1.36666666666667 + var_115_16 + arg_115_0 then
				var_115_15.localPosition = Vector3.New(0, 100, 0)
				var_115_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_15.position).x, (manager.ui.mainCamera.transform.position - var_115_15.position).y, (manager.ui.mainCamera.transform.position - var_115_15.position).z)
				var_115_15.localEulerAngles.z = 0
				var_115_15.localEulerAngles.x = 0
				var_115_15.localEulerAngles = var_115_15.localEulerAngles
			end

			if 1.2 < arg_112_1.time_ and arg_112_1.time_ <= 1.2 + arg_115_0 then
				arg_112_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_command room", "")
			end

			if 0.2 < arg_112_1.time_ and arg_112_1.time_ <= 0.2 + arg_115_0 then
				arg_112_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if arg_112_1.frameCnt_ <= 1 then
				arg_112_1.dialog_:SetActive(false)
			end

			local var_115_19 = 2.9
			local var_115_20 = 1.65

			if 2.9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_19 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_21 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_21:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_22 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(304052033).content)

				arg_112_1.text_.text = var_115_22

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_24 = 66 <= 0 and var_115_20 or var_115_20 * (utf8.len(var_115_22) / 66)

				if (66 <= 0 and var_115_20 or var_115_20 * (utf8.len(var_115_22) / 66)) > 0 and var_115_20 < var_115_24 then
					arg_112_1.talkMaxDuration = var_115_24
					var_115_19 = var_115_19 + 0.3

					if var_115_24 + var_115_19 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_24 + var_115_19
					end
				end

				arg_112_1.text_.text = var_115_22
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_25 = var_115_19 + 0.3
			local var_115_26 = math.max(var_115_20, arg_112_1.talkMaxDuration)

			if var_115_19 + 0.3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_25 + var_115_26 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_25) / var_115_26

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_25 + var_115_26 and arg_112_1.time_ < var_115_25 + var_115_26 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play304052034 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 304052034
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play304052035(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 1

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(304052034).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 40 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 40)

				if (40 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 40)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play304052035 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 304052035
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play304052036(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.575

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(304052035).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 23 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 23)

				if (23 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 23)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play304052036 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 304052036
		arg_126_1.duration_ = 9.83

		local var_126_0 = {
			zh = 9.833,
			ja = 1.999999999999
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
				arg_126_0:Play304052037(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if arg_126_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_129_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_126_1.stage_.transform)

				var_129_0.name = "1037ui_story"
				var_129_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["1037ui_story"] = var_129_0

				local var_129_1 = var_129_0:GetComponentInChildren(typeof(CharacterEffect))

				var_129_1.enabled = true

				local var_129_2 = GameObjectTools.GetOrAddComponent(var_129_0, typeof(DynamicBoneHelper))

				if var_129_2 then
					var_129_2:EnableDynamicBone(false)
				end

				arg_126_1:ShowWeapon(var_129_1.transform, false)

				arg_126_1.var_["1037ui_story" .. "Animator"] = var_129_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_126_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_126_1.var_["1037ui_story" .. "LipSync"] = var_129_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_129_3 = arg_126_1.actors_["1037ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1037ui_story = var_129_3.localPosition
			end

			local var_129_4 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				var_129_3.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_126_1.time_ - 0) / var_129_4)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				var_129_3.localPosition = Vector3.New(0, -1.09, -5.81)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			local var_129_5 = arg_126_1.actors_["1037ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1037ui_story == nil then
				arg_126_1.var_.characterEffect1037ui_story = var_129_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 and not isNil(var_129_5) then
				if arg_126_1.var_.characterEffect1037ui_story and not isNil(var_129_5) then
					arg_126_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 and not isNil(var_129_5) and arg_126_1.var_.characterEffect1037ui_story then
				arg_126_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_129_8 = 0
			local var_129_9 = 1.15

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_10 = arg_126_1:GetWordFromCfg(304052036)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 46 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 46)

				if (46 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 46)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052036", "story_v_out_304052.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_304052", "304052036", "story_v_out_304052.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_304052", "304052036", "story_v_out_304052.awb")

						arg_126_1:RecordAudio("304052036", var_129_15)
						arg_126_1:RecordAudio("304052036", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_304052", "304052036", "story_v_out_304052.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_304052", "304052036", "story_v_out_304052.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play304052037 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 304052037
		arg_130_1.duration_ = 4.4

		local var_130_0 = {
			zh = 4.4,
			ja = 1.333
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play304052038(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.575

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:GetWordFromCfg(304052037)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 23 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 23)

				if (23 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 23)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052037", "story_v_out_304052.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052037", "story_v_out_304052.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_304052", "304052037", "story_v_out_304052.awb")

						arg_130_1:RecordAudio("304052037", var_133_6)
						arg_130_1:RecordAudio("304052037", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_304052", "304052037", "story_v_out_304052.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_304052", "304052037", "story_v_out_304052.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_7 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_7

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play304052038 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 304052038
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play304052039(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1037ui_story = arg_134_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_137_0 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 then
				arg_134_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 0) / var_137_0)
				arg_134_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1037ui_story"].transform.position).z)
				arg_134_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1037ui_story"].transform.localEulerAngles = arg_134_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 then
				arg_134_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_134_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_134_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_134_1.actors_["1037ui_story"].transform.position).z)
				arg_134_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_134_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_134_1.actors_["1037ui_story"].transform.localEulerAngles = arg_134_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_137_1 = arg_134_1.actors_["1037ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1037ui_story == nil then
				arg_134_1.var_.characterEffect1037ui_story = var_137_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_2 and not isNil(var_137_1) then
				if arg_134_1.var_.characterEffect1037ui_story and not isNil(var_137_1) then
					arg_134_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_2)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_2 and arg_134_1.time_ < 0 + var_137_2 + arg_137_0 and not isNil(var_137_1) and arg_134_1.var_.characterEffect1037ui_story then
				arg_134_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_137_3 = 0
			local var_137_4 = 1.525

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_3 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_5 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(304052038).content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 62 <= 0 and var_137_4 or var_137_4 * (utf8.len(var_137_5) / 62)

				if (62 <= 0 and var_137_4 or var_137_4 * (utf8.len(var_137_5) / 62)) > 0 and var_137_4 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_3 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_3
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_8 = math.max(var_137_4, arg_134_1.talkMaxDuration)

			if var_137_3 <= arg_134_1.time_ and arg_134_1.time_ < var_137_3 + var_137_8 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_3) / var_137_8

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_3 + var_137_8 and arg_134_1.time_ < var_137_3 + var_137_8 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play304052039 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 304052039
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play304052040(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.275

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_1 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(304052039).content)

				arg_138_1.text_.text = var_141_1

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_3 = 11 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 11)

				if (11 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 11)) > 0 and var_141_0 < var_141_3 then
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
	Play304052040 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 304052040
		arg_142_1.duration_ = 8.5

		local var_142_0 = {
			zh = 8.5,
			ja = 1.999999999999
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
				arg_142_0:Play304052041(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1037ui_story = arg_142_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_145_0 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 then
				arg_142_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_142_1.time_ - 0) / var_145_0)
				arg_142_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1037ui_story"].transform.position).z)
				arg_142_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["1037ui_story"].transform.localEulerAngles = arg_142_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 then
				arg_142_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_142_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["1037ui_story"].transform.position).z)
				arg_142_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["1037ui_story"].transform.localEulerAngles = arg_142_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_145_1 = arg_142_1.actors_["1037ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_1) and arg_142_1.var_.characterEffect1037ui_story == nil then
				arg_142_1.var_.characterEffect1037ui_story = var_145_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_2 and not isNil(var_145_1) then
				if arg_142_1.var_.characterEffect1037ui_story and not isNil(var_145_1) then
					arg_142_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_2 and arg_142_1.time_ < 0 + var_145_2 + arg_145_0 and not isNil(var_145_1) and arg_142_1.var_.characterEffect1037ui_story then
				arg_142_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action435")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_145_4 = 0
			local var_145_5 = 0.9

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(304052040)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 36 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 36)

				if (36 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_7) / 36)) > 0 and var_145_5 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052040", "story_v_out_304052.awb") ~= 0 then
					local var_145_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052040", "story_v_out_304052.awb") / 1000

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end

					if var_145_6.prefab_name ~= "" and arg_142_1.actors_[var_145_6.prefab_name] ~= nil then
						local var_145_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_6.prefab_name].transform, "story_v_out_304052", "304052040", "story_v_out_304052.awb")

						arg_142_1:RecordAudio("304052040", var_145_11)
						arg_142_1:RecordAudio("304052040", var_145_11)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_304052", "304052040", "story_v_out_304052.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_304052", "304052040", "story_v_out_304052.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_12 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_12 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_12

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_12 and arg_142_1.time_ < var_145_4 + var_145_12 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play304052041 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 304052041
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play304052042(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["1037ui_story"]) and arg_146_1.var_.characterEffect1037ui_story == nil then
				arg_146_1.var_.characterEffect1037ui_story = arg_146_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["1037ui_story"]) then
				if arg_146_1.var_.characterEffect1037ui_story and not isNil(arg_146_1.actors_["1037ui_story"]) then
					arg_146_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_0)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["1037ui_story"]) and arg_146_1.var_.characterEffect1037ui_story then
				arg_146_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_149_1 = 0
			local var_149_2 = 0.825

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_3 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(304052041).content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 33 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 33)

				if (33 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 33)) > 0 and var_149_2 < var_149_5 then
					arg_146_1.talkMaxDuration = var_149_5

					if var_149_5 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + var_149_1
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_6 = math.max(var_149_2, arg_146_1.talkMaxDuration)

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_6 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_1) / var_149_6

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_1 + var_149_6 and arg_146_1.time_ < var_149_1 + var_149_6 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play304052042 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 304052042
		arg_150_1.duration_ = 17.17

		local var_150_0 = {
			zh = 17.1666666666667,
			ja = 5.441666666666
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play304052043(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if arg_150_1.bgs_.S0104 == nil then
				local var_153_0 = Object.Instantiate(arg_150_1.paintGo_)

				var_153_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0104")
				var_153_0.name = "S0104"
				var_153_0.transform.parent = arg_150_1.stage_.transform
				var_153_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.bgs_.S0104 = var_153_0
			end

			if 1.65 < arg_150_1.time_ and arg_150_1.time_ <= 1.65 + arg_153_0 then
				local var_153_1 = arg_150_1.bgs_.S0104

				arg_150_1.bgs_.S0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_153_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_153_2 = var_153_1:GetComponent("SpriteRenderer")

				if var_153_2 and var_153_2.sprite then
					local var_153_3 = 2 * (var_153_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_153_1.transform.localScale = Vector3.New(var_153_3 / var_153_2.sprite.bounds.size.y < var_153_3 * manager.ui.mainCameraCom_.aspect / var_153_2.sprite.bounds.size.x and var_153_3 * manager.ui.mainCameraCom_.aspect / var_153_2.sprite.bounds.size.x or var_153_3 / var_153_2.sprite.bounds.size.y, var_153_3 / var_153_2.sprite.bounds.size.y < var_153_3 * manager.ui.mainCameraCom_.aspect / var_153_2.sprite.bounds.size.x and var_153_3 * manager.ui.mainCameraCom_.aspect / var_153_2.sprite.bounds.size.x or var_153_3 / var_153_2.sprite.bounds.size.y, 0)
				end

				for iter_153_0, iter_153_1 in pairs(arg_150_1.bgs_) do
					if iter_153_0 ~= "S0104" then
						iter_153_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_153_4 = 1.66666666666667

			if 1.66666666666667 < arg_150_1.time_ and arg_150_1.time_ <= var_153_4 + arg_153_0 then
				arg_150_1.allBtn_.enabled = false
			end

			if arg_150_1.time_ >= var_153_4 + 0.3 and arg_150_1.time_ < var_153_4 + 0.3 + arg_153_0 then
				arg_150_1.allBtn_.enabled = true
			end

			local var_153_5 = 0

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_6 = 1.66666666666667

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 then
				local var_153_7 = Color.New(0, 0, 0)

				var_153_7.a = Mathf.Lerp(0, 1, (arg_150_1.time_ - var_153_5) / var_153_6)
				arg_150_1.mask_.color = var_153_7
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 then
				local var_153_8 = Color.New(0, 0, 0)

				var_153_8.a = 1
				arg_150_1.mask_.color = var_153_8
			end

			local var_153_9 = 1.66666666666667

			if 1.66666666666667 < arg_150_1.time_ and arg_150_1.time_ <= var_153_9 + arg_153_0 then
				arg_150_1.mask_.enabled = true
				arg_150_1.mask_.raycastTarget = true

				arg_150_1:SetGaussion(false)
			end

			local var_153_10 = 2

			if var_153_9 <= arg_150_1.time_ and arg_150_1.time_ < var_153_9 + var_153_10 then
				local var_153_11 = Color.New(0, 0, 0)

				var_153_11.a = Mathf.Lerp(1, 0, (arg_150_1.time_ - var_153_9) / var_153_10)
				arg_150_1.mask_.color = var_153_11
			end

			if arg_150_1.time_ >= var_153_9 + var_153_10 and arg_150_1.time_ < var_153_9 + var_153_10 + arg_153_0 then
				local var_153_12 = Color.New(0, 0, 0)

				arg_150_1.mask_.enabled = false
				var_153_12.a = 0
				arg_150_1.mask_.color = var_153_12
			end

			local var_153_13 = arg_150_1.actors_["1037ui_story"].transform

			if 1.66666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 1.66666666666667 + arg_153_0 then
				arg_150_1.var_.moveOldPos1037ui_story = var_153_13.localPosition
			end

			local var_153_14 = 0.001

			if 1.66666666666667 <= arg_150_1.time_ and arg_150_1.time_ < 1.66666666666667 + var_153_14 then
				var_153_13.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 1.66666666666667) / var_153_14)
				var_153_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_13.position).x, (manager.ui.mainCamera.transform.position - var_153_13.position).y, (manager.ui.mainCamera.transform.position - var_153_13.position).z)
				var_153_13.localEulerAngles.z = 0
				var_153_13.localEulerAngles.x = 0
				var_153_13.localEulerAngles = var_153_13.localEulerAngles
			end

			if arg_150_1.time_ >= 1.66666666666667 + var_153_14 and arg_150_1.time_ < 1.66666666666667 + var_153_14 + arg_153_0 then
				var_153_13.localPosition = Vector3.New(0, 100, 0)
				var_153_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_13.position).x, (manager.ui.mainCamera.transform.position - var_153_13.position).y, (manager.ui.mainCamera.transform.position - var_153_13.position).z)
				var_153_13.localEulerAngles.z = 0
				var_153_13.localEulerAngles.x = 0
				var_153_13.localEulerAngles = var_153_13.localEulerAngles
			end

			local var_153_15 = arg_150_1.actors_["1037ui_story"]

			if 1.66666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 1.66666666666667 + arg_153_0 and not isNil(var_153_15) and arg_150_1.var_.characterEffect1037ui_story == nil then
				arg_150_1.var_.characterEffect1037ui_story = var_153_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_16 = 0.200000002980232

			if 1.66666666666667 <= arg_150_1.time_ and arg_150_1.time_ < 1.66666666666667 + var_153_16 and not isNil(var_153_15) then
				if arg_150_1.var_.characterEffect1037ui_story and not isNil(var_153_15) then
					arg_150_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 1.66666666666667 + var_153_16 and arg_150_1.time_ < 1.66666666666667 + var_153_16 + arg_153_0 and not isNil(var_153_15) and arg_150_1.var_.characterEffect1037ui_story then
				arg_150_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_153_18 = arg_150_1.bgs_.S0104.transform

			if 1.66666666666667 < arg_150_1.time_ and arg_150_1.time_ <= 1.66666666666667 + arg_153_0 then
				arg_150_1.var_.moveOldPosS0104 = var_153_18.localPosition
			end

			local var_153_19 = 2.26666666666667

			if 1.66666666666667 <= arg_150_1.time_ and arg_150_1.time_ < 1.66666666666667 + var_153_19 then
				var_153_18.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPosS0104, Vector3.New(0, 1, 8), (arg_150_1.time_ - 1.66666666666667) / var_153_19)
			end

			if arg_150_1.time_ >= 1.66666666666667 + var_153_19 and arg_150_1.time_ < 1.66666666666667 + var_153_19 + arg_153_0 then
				var_153_18.localPosition = Vector3.New(0, 1, 8)
			end

			if arg_150_1.frameCnt_ <= 1 then
				arg_150_1.dialog_:SetActive(false)
			end

			local var_153_20 = 3.76666666666667
			local var_153_21 = 1.675

			if 3.76666666666667 < arg_150_1.time_ and arg_150_1.time_ <= var_153_20 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0

				arg_150_1.dialog_:SetActive(true)

				arg_150_1.dialogCg_.alpha = 0

				local var_153_22 = LeanTween.value(arg_150_1.dialog_, 0, 1, 0.3)

				var_153_22:setOnUpdate(LuaHelper.FloatAction(function(arg_154_0)
					arg_150_1.dialogCg_.alpha = arg_154_0
				end))
				var_153_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_150_1.dialog_)
					var_153_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_150_1.duration_ = arg_150_1.duration_ + 0.3

				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_23 = arg_150_1:GetWordFromCfg(304052042)
				local var_153_24 = arg_150_1:FormatText(var_153_23.content)

				arg_150_1.text_.text = var_153_24

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_26 = 67 <= 0 and var_153_21 or var_153_21 * (utf8.len(var_153_24) / 67)

				if (67 <= 0 and var_153_21 or var_153_21 * (utf8.len(var_153_24) / 67)) > 0 and var_153_21 < var_153_26 then
					arg_150_1.talkMaxDuration = var_153_26
					var_153_20 = var_153_20 + 0.3

					if var_153_26 + var_153_20 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_26 + var_153_20
					end
				end

				arg_150_1.text_.text = var_153_24
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052042", "story_v_out_304052.awb") ~= 0 then
					local var_153_27 = manager.audio:GetVoiceLength("story_v_out_304052", "304052042", "story_v_out_304052.awb") / 1000

					if var_153_27 + var_153_20 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_27 + var_153_20
					end

					if var_153_23.prefab_name ~= "" and arg_150_1.actors_[var_153_23.prefab_name] ~= nil then
						local var_153_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_23.prefab_name].transform, "story_v_out_304052", "304052042", "story_v_out_304052.awb")

						arg_150_1:RecordAudio("304052042", var_153_28)
						arg_150_1:RecordAudio("304052042", var_153_28)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_304052", "304052042", "story_v_out_304052.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_304052", "304052042", "story_v_out_304052.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_29 = var_153_20 + 0.3
			local var_153_30 = math.max(var_153_21, arg_150_1.talkMaxDuration)

			if var_153_20 + 0.3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_29 + var_153_30 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_29) / var_153_30

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_29 + var_153_30 and arg_150_1.time_ < var_153_29 + var_153_30 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0104",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.26666666666667,
				startTime = 1.66666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0.26, 1, 5),
					endPos = Vector3.New(0, 1, 8),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play304052043 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 304052043
		arg_156_1.duration_ = 15.93

		local var_156_0 = {
			zh = 15.933,
			ja = 1.949999999999
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play304052044(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.95

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:GetWordFromCfg(304052043)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 78 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 78)

				if (78 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 78)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052043", "story_v_out_304052.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052043", "story_v_out_304052.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_304052", "304052043", "story_v_out_304052.awb")

						arg_156_1:RecordAudio("304052043", var_159_6)
						arg_156_1:RecordAudio("304052043", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_304052", "304052043", "story_v_out_304052.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_304052", "304052043", "story_v_out_304052.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play304052044 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 304052044
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play304052045(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1037ui_story"]) and arg_160_1.var_.characterEffect1037ui_story == nil then
				arg_160_1.var_.characterEffect1037ui_story = arg_160_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1037ui_story"]) then
				if arg_160_1.var_.characterEffect1037ui_story and not isNil(arg_160_1.actors_["1037ui_story"]) then
					arg_160_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1037ui_story"]) and arg_160_1.var_.characterEffect1037ui_story then
				arg_160_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_163_1 = 0
			local var_163_2 = 0.875

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_3 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(304052044).content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 35 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 35)

				if (35 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_3) / 35)) > 0 and var_163_2 < var_163_5 then
					arg_160_1.talkMaxDuration = var_163_5

					if var_163_5 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_6 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_6 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_6

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_6 and arg_160_1.time_ < var_163_1 + var_163_6 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play304052045 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 304052045
		arg_164_1.duration_ = 9.5

		local var_164_0 = {
			zh = 9.5,
			ja = 1.333
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play304052046(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 1.125

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:GetWordFromCfg(304052045)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 45 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 45)

				if (45 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 45)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052045", "story_v_out_304052.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052045", "story_v_out_304052.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_304052", "304052045", "story_v_out_304052.awb")

						arg_164_1:RecordAudio("304052045", var_167_6)
						arg_164_1:RecordAudio("304052045", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_304052", "304052045", "story_v_out_304052.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_304052", "304052045", "story_v_out_304052.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play304052046 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 304052046
		arg_168_1.duration_ = 9.57

		local var_168_0 = {
			zh = 9.566,
			ja = 1.333
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play304052047(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 1.15

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:GetWordFromCfg(304052046)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 46 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 46)

				if (46 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 46)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052046", "story_v_out_304052.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052046", "story_v_out_304052.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_304052", "304052046", "story_v_out_304052.awb")

						arg_168_1:RecordAudio("304052046", var_171_6)
						arg_168_1:RecordAudio("304052046", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_304052", "304052046", "story_v_out_304052.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_304052", "304052046", "story_v_out_304052.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play304052047 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 304052047
		arg_172_1.duration_ = 10.5

		local var_172_0 = {
			zh = 10.5,
			ja = 1.333
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play304052048(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 1.2

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(304052047)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 48 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 48)

				if (48 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 48)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052047", "story_v_out_304052.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052047", "story_v_out_304052.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_304052", "304052047", "story_v_out_304052.awb")

						arg_172_1:RecordAudio("304052047", var_175_6)
						arg_172_1:RecordAudio("304052047", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_304052", "304052047", "story_v_out_304052.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_304052", "304052047", "story_v_out_304052.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play304052048 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 304052048
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play304052049(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1037ui_story"]) and arg_176_1.var_.characterEffect1037ui_story == nil then
				arg_176_1.var_.characterEffect1037ui_story = arg_176_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1037ui_story"]) then
				if arg_176_1.var_.characterEffect1037ui_story and not isNil(arg_176_1.actors_["1037ui_story"]) then
					arg_176_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_0)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1037ui_story"]) and arg_176_1.var_.characterEffect1037ui_story then
				arg_176_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_179_1 = 0
			local var_179_2 = 1.1

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_3 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(304052048).content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 44 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 44)

				if (44 <= 0 and var_179_2 or var_179_2 * (utf8.len(var_179_3) / 44)) > 0 and var_179_2 < var_179_5 then
					arg_176_1.talkMaxDuration = var_179_5

					if var_179_5 + var_179_1 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + var_179_1
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_6 = math.max(var_179_2, arg_176_1.talkMaxDuration)

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_6 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_1) / var_179_6

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_1 + var_179_6 and arg_176_1.time_ < var_179_1 + var_179_6 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play304052049 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 304052049
		arg_180_1.duration_ = 12.93

		local var_180_0 = {
			zh = 12.933,
			ja = 1.599999999999
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play304052050(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1037ui_story"]) and arg_180_1.var_.characterEffect1037ui_story == nil then
				arg_180_1.var_.characterEffect1037ui_story = arg_180_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1037ui_story"]) then
				if arg_180_1.var_.characterEffect1037ui_story and not isNil(arg_180_1.actors_["1037ui_story"]) then
					arg_180_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1037ui_story"]) and arg_180_1.var_.characterEffect1037ui_story then
				arg_180_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_183_2 = 0
			local var_183_3 = 1.6

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_4 = arg_180_1:GetWordFromCfg(304052049)
				local var_183_5 = arg_180_1:FormatText(var_183_4.content)

				arg_180_1.text_.text = var_183_5

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_7 = 64 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_5) / 64)

				if (64 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_5) / 64)) > 0 and var_183_3 < var_183_7 then
					arg_180_1.talkMaxDuration = var_183_7

					if var_183_7 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_5
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052049", "story_v_out_304052.awb") ~= 0 then
					local var_183_8 = manager.audio:GetVoiceLength("story_v_out_304052", "304052049", "story_v_out_304052.awb") / 1000

					if var_183_8 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_2
					end

					if var_183_4.prefab_name ~= "" and arg_180_1.actors_[var_183_4.prefab_name] ~= nil then
						local var_183_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_4.prefab_name].transform, "story_v_out_304052", "304052049", "story_v_out_304052.awb")

						arg_180_1:RecordAudio("304052049", var_183_9)
						arg_180_1:RecordAudio("304052049", var_183_9)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_304052", "304052049", "story_v_out_304052.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_304052", "304052049", "story_v_out_304052.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_10 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 <= arg_180_1.time_ and arg_180_1.time_ < var_183_2 + var_183_10 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_2) / var_183_10

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_2 + var_183_10 and arg_180_1.time_ < var_183_2 + var_183_10 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play304052050 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 304052050
		arg_184_1.duration_ = 8.6

		local var_184_0 = {
			zh = 8.6,
			ja = 1.333
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play304052051(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0.975

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_1 = arg_184_1:GetWordFromCfg(304052050)
				local var_187_2 = arg_184_1:FormatText(var_187_1.content)

				arg_184_1.text_.text = var_187_2

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_4 = 39 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 39)

				if (39 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 39)) > 0 and var_187_0 < var_187_4 then
					arg_184_1.talkMaxDuration = var_187_4

					if var_187_4 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_4 + 0
					end
				end

				arg_184_1.text_.text = var_187_2
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052050", "story_v_out_304052.awb") ~= 0 then
					local var_187_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052050", "story_v_out_304052.awb") / 1000

					if var_187_5 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + 0
					end

					if var_187_1.prefab_name ~= "" and arg_184_1.actors_[var_187_1.prefab_name] ~= nil then
						local var_187_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_1.prefab_name].transform, "story_v_out_304052", "304052050", "story_v_out_304052.awb")

						arg_184_1:RecordAudio("304052050", var_187_6)
						arg_184_1:RecordAudio("304052050", var_187_6)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_304052", "304052050", "story_v_out_304052.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_304052", "304052050", "story_v_out_304052.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play304052051 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 304052051
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play304052052(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1037ui_story"]) and arg_188_1.var_.characterEffect1037ui_story == nil then
				arg_188_1.var_.characterEffect1037ui_story = arg_188_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1037ui_story"]) then
				if arg_188_1.var_.characterEffect1037ui_story and not isNil(arg_188_1.actors_["1037ui_story"]) then
					arg_188_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_0)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1037ui_story"]) and arg_188_1.var_.characterEffect1037ui_story then
				arg_188_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_191_1 = 0
			local var_191_2 = 0.25

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_3 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(304052051).content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 10 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 10)

				if (10 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_3) / 10)) > 0 and var_191_2 < var_191_5 then
					arg_188_1.talkMaxDuration = var_191_5

					if var_191_5 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_6 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_6 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_6

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_6 and arg_188_1.time_ < var_191_1 + var_191_6 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play304052052 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 304052052
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play304052053(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.95

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(304052052).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 38 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 38)

				if (38 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 38)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play304052053 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 304052053
		arg_196_1.duration_ = 7.97

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play304052054(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 1.6 < arg_196_1.time_ and arg_196_1.time_ <= 1.6 + arg_199_0 then
				local var_199_0 = arg_196_1.bgs_.A00

				arg_196_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_199_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_199_1 = var_199_0:GetComponent("SpriteRenderer")

				if var_199_1 and var_199_1.sprite then
					local var_199_2 = 2 * (var_199_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_199_0.transform.localScale = Vector3.New(var_199_2 / var_199_1.sprite.bounds.size.y < var_199_2 * manager.ui.mainCameraCom_.aspect / var_199_1.sprite.bounds.size.x and var_199_2 * manager.ui.mainCameraCom_.aspect / var_199_1.sprite.bounds.size.x or var_199_2 / var_199_1.sprite.bounds.size.y, var_199_2 / var_199_1.sprite.bounds.size.y < var_199_2 * manager.ui.mainCameraCom_.aspect / var_199_1.sprite.bounds.size.x and var_199_2 * manager.ui.mainCameraCom_.aspect / var_199_1.sprite.bounds.size.x or var_199_2 / var_199_1.sprite.bounds.size.y, 0)
				end

				for iter_199_0, iter_199_1 in pairs(arg_196_1.bgs_) do
					if iter_199_0 ~= "A00" then
						iter_199_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_199_3 = 0

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_3 + arg_199_0 then
				arg_196_1.allBtn_.enabled = false
			end

			if arg_196_1.time_ >= var_199_3 + 0.3 and arg_196_1.time_ < var_199_3 + 0.3 + arg_199_0 then
				arg_196_1.allBtn_.enabled = true
			end

			local var_199_4 = 0

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_5 = 1.6

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_5 then
				local var_199_6 = Color.New(0, 0, 0)

				var_199_6.a = Mathf.Lerp(0, 1, (arg_196_1.time_ - var_199_4) / var_199_5)
				arg_196_1.mask_.color = var_199_6
			end

			if arg_196_1.time_ >= var_199_4 + var_199_5 and arg_196_1.time_ < var_199_4 + var_199_5 + arg_199_0 then
				local var_199_7 = Color.New(0, 0, 0)

				var_199_7.a = 1
				arg_196_1.mask_.color = var_199_7
			end

			local var_199_8 = 1.6

			if 1.6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 then
				arg_196_1.mask_.enabled = true
				arg_196_1.mask_.raycastTarget = true

				arg_196_1:SetGaussion(false)
			end

			local var_199_9 = 1.6

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_9 then
				local var_199_10 = Color.New(0, 0, 0)

				var_199_10.a = Mathf.Lerp(1, 0, (arg_196_1.time_ - var_199_8) / var_199_9)
				arg_196_1.mask_.color = var_199_10
			end

			if arg_196_1.time_ >= var_199_8 + var_199_9 and arg_196_1.time_ < var_199_8 + var_199_9 + arg_199_0 then
				local var_199_11 = Color.New(0, 0, 0)

				arg_196_1.mask_.enabled = false
				var_199_11.a = 0
				arg_196_1.mask_.color = var_199_11
			end

			if arg_196_1.frameCnt_ <= 1 then
				arg_196_1.dialog_:SetActive(false)
			end

			local var_199_12 = 2.96666666666667
			local var_199_13 = 1.6

			if 2.96666666666667 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0

				arg_196_1.dialog_:SetActive(true)

				arg_196_1.dialogCg_.alpha = 0

				local var_199_14 = LeanTween.value(arg_196_1.dialog_, 0, 1, 0.3)

				var_199_14:setOnUpdate(LuaHelper.FloatAction(function(arg_200_0)
					arg_196_1.dialogCg_.alpha = arg_200_0
				end))
				var_199_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_196_1.dialog_)
					var_199_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_196_1.duration_ = arg_196_1.duration_ + 0.3

				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_15 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(304052053).content)

				arg_196_1.text_.text = var_199_15

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_17 = 64 <= 0 and var_199_13 or var_199_13 * (utf8.len(var_199_15) / 64)

				if (64 <= 0 and var_199_13 or var_199_13 * (utf8.len(var_199_15) / 64)) > 0 and var_199_13 < var_199_17 then
					arg_196_1.talkMaxDuration = var_199_17
					var_199_12 = var_199_12 + 0.3

					if var_199_17 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_17 + var_199_12
					end
				end

				arg_196_1.text_.text = var_199_15
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_18 = var_199_12 + 0.3
			local var_199_19 = math.max(var_199_13, arg_196_1.talkMaxDuration)

			if var_199_12 + 0.3 <= arg_196_1.time_ and arg_196_1.time_ < var_199_18 + var_199_19 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_18) / var_199_19

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_18 + var_199_19 and arg_196_1.time_ < var_199_18 + var_199_19 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play304052054 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 304052054
		arg_202_1.duration_ = 6.13

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play304052055(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.allBtn_.enabled = false
			end

			if arg_202_1.time_ >= 0 + 1.28333333333333 and arg_202_1.time_ < 0 + 1.28333333333333 + arg_205_0 then
				arg_202_1.allBtn_.enabled = true
			end

			if 0.2 < arg_202_1.time_ and arg_202_1.time_ <= 0.2 + arg_205_0 then
				arg_202_1:AudioAction("play", "effect", "se_story_152", "se_story_152_explosion_phone", "")
			end

			if arg_202_1.frameCnt_ <= 1 then
				arg_202_1.dialog_:SetActive(false)
			end

			local var_205_1 = 1.13333333333333
			local var_205_2 = 0.15

			if 1.13333333333333 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0

				arg_202_1.dialog_:SetActive(true)

				arg_202_1.dialogCg_.alpha = 0

				local var_205_3 = LeanTween.value(arg_202_1.dialog_, 0, 1, 0.3)

				var_205_3:setOnUpdate(LuaHelper.FloatAction(function(arg_206_0)
					arg_202_1.dialogCg_.alpha = arg_206_0
				end))
				var_205_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_202_1.dialog_)
					var_205_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_202_1.duration_ = arg_202_1.duration_ + 0.3

				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_4 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(304052054).content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_6 = 6 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_4) / 6)

				if (6 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_4) / 6)) > 0 and var_205_2 < var_205_6 then
					arg_202_1.talkMaxDuration = var_205_6
					var_205_1 = var_205_1 + 0.3

					if var_205_6 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_6 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_7 = var_205_1 + 0.3
			local var_205_8 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 + 0.3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_7 + var_205_8 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_7) / var_205_8

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_7 + var_205_8 and arg_202_1.time_ < var_205_7 + var_205_8 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play304052055 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 304052055
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play304052056(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.175

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(304052055).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 7 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 7)

				if (7 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 7)) > 0 and var_211_0 < var_211_3 then
					arg_208_1.talkMaxDuration = var_211_3

					if var_211_3 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_3 + 0
					end
				end

				arg_208_1.text_.text = var_211_1
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_4 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_4

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play304052056 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 304052056
		arg_212_1.duration_ = 3.9

		local var_212_0 = {
			zh = 3.9,
			ja = 1.999999999999
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play304052057(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1037ui_story = arg_212_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1037ui_story"].transform.position).z)
				arg_212_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1037ui_story"].transform.localEulerAngles = arg_212_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_212_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1037ui_story"].transform.position).z)
				arg_212_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1037ui_story"].transform.localEulerAngles = arg_212_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["1037ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect1037ui_story == nil then
				arg_212_1.var_.characterEffect1037ui_story = var_215_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_2 and not isNil(var_215_1) then
				if arg_212_1.var_.characterEffect1037ui_story and not isNil(var_215_1) then
					arg_212_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_2 and arg_212_1.time_ < 0 + var_215_2 + arg_215_0 and not isNil(var_215_1) and arg_212_1.var_.characterEffect1037ui_story then
				arg_212_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_2")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_215_4 = 0
			local var_215_5 = 0.55

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(304052056)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 22 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 22)

				if (22 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 22)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052056", "story_v_out_304052.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052056", "story_v_out_304052.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_out_304052", "304052056", "story_v_out_304052.awb")

						arg_212_1:RecordAudio("304052056", var_215_11)
						arg_212_1:RecordAudio("304052056", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_304052", "304052056", "story_v_out_304052.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_304052", "304052056", "story_v_out_304052.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play304052057 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 304052057
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play304052058(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1037ui_story"]) and arg_216_1.var_.characterEffect1037ui_story == nil then
				arg_216_1.var_.characterEffect1037ui_story = arg_216_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1037ui_story"]) then
				if arg_216_1.var_.characterEffect1037ui_story and not isNil(arg_216_1.actors_["1037ui_story"]) then
					arg_216_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_0)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1037ui_story"]) and arg_216_1.var_.characterEffect1037ui_story then
				arg_216_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_219_1 = 0
			local var_219_2 = 0.2

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_3 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(304052057).content)

				arg_216_1.text_.text = var_219_3

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 8 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 8)

				if (8 <= 0 and var_219_2 or var_219_2 * (utf8.len(var_219_3) / 8)) > 0 and var_219_2 < var_219_5 then
					arg_216_1.talkMaxDuration = var_219_5

					if var_219_5 + var_219_1 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + var_219_1
					end
				end

				arg_216_1.text_.text = var_219_3
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_6 = math.max(var_219_2, arg_216_1.talkMaxDuration)

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_6 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_1) / var_219_6

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_1 + var_219_6 and arg_216_1.time_ < var_219_1 + var_219_6 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play304052058 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 304052058
		arg_220_1.duration_ = 8.73

		local var_220_0 = {
			zh = 6.966,
			ja = 8.733
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play304052059(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1148ui_story"]) and arg_220_1.var_.characterEffect1148ui_story == nil then
				arg_220_1.var_.characterEffect1148ui_story = arg_220_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1148ui_story"]) then
				if arg_220_1.var_.characterEffect1148ui_story and not isNil(arg_220_1.actors_["1148ui_story"]) then
					arg_220_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1148ui_story"]) and arg_220_1.var_.characterEffect1148ui_story then
				arg_220_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_223_2 = 0
			local var_223_3 = 0.8

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_2 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_220_1.callingController_:SetSelectedState("calling")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_4 = arg_220_1:GetWordFromCfg(304052058)
				local var_223_5 = arg_220_1:FormatText(var_223_4.content)

				arg_220_1.text_.text = var_223_5

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_7 = 32 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 32)

				if (32 <= 0 and var_223_3 or var_223_3 * (utf8.len(var_223_5) / 32)) > 0 and var_223_3 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_2
					end
				end

				arg_220_1.text_.text = var_223_5
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052058", "story_v_out_304052.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_304052", "304052058", "story_v_out_304052.awb") / 1000

					if var_223_8 + var_223_2 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_2
					end

					if var_223_4.prefab_name ~= "" and arg_220_1.actors_[var_223_4.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_4.prefab_name].transform, "story_v_out_304052", "304052058", "story_v_out_304052.awb")

						arg_220_1:RecordAudio("304052058", var_223_9)
						arg_220_1:RecordAudio("304052058", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_304052", "304052058", "story_v_out_304052.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_304052", "304052058", "story_v_out_304052.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_3, arg_220_1.talkMaxDuration)

			if var_223_2 <= arg_220_1.time_ and arg_220_1.time_ < var_223_2 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_2) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_2 + var_223_10 and arg_220_1.time_ < var_223_2 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play304052059 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 304052059
		arg_224_1.duration_ = 7.13

		local var_224_0 = {
			zh = 6.666,
			ja = 7.133
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play304052060(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.875

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_224_1.callingController_:SetSelectedState("calling")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_1 = arg_224_1:GetWordFromCfg(304052059)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 35 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 35)

				if (35 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 35)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052059", "story_v_out_304052.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_304052", "304052059", "story_v_out_304052.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_304052", "304052059", "story_v_out_304052.awb")

						arg_224_1:RecordAudio("304052059", var_227_6)
						arg_224_1:RecordAudio("304052059", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_304052", "304052059", "story_v_out_304052.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_304052", "304052059", "story_v_out_304052.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play304052060 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 304052060
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
			arg_228_1.auto_ = false
		end

		function arg_228_1.playNext_(arg_230_0)
			arg_228_1.onStoryFinished_()
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1148ui_story"]) and arg_228_1.var_.characterEffect1148ui_story == nil then
				arg_228_1.var_.characterEffect1148ui_story = arg_228_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1148ui_story"]) then
				if arg_228_1.var_.characterEffect1148ui_story and not isNil(arg_228_1.actors_["1148ui_story"]) then
					arg_228_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_0)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1148ui_story"]) and arg_228_1.var_.characterEffect1148ui_story then
				arg_228_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_231_1 = 0
			local var_231_2 = 0.4

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_3 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(304052060).content)

				arg_228_1.text_.text = var_231_3

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 16 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 16)

				if (16 <= 0 and var_231_2 or var_231_2 * (utf8.len(var_231_3) / 16)) > 0 and var_231_2 < var_231_5 then
					arg_228_1.talkMaxDuration = var_231_5

					if var_231_5 + var_231_1 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + var_231_1
					end
				end

				arg_228_1.text_.text = var_231_3
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_6 = math.max(var_231_2, arg_228_1.talkMaxDuration)

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_6 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_1) / var_231_6

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_1 + var_231_6 and arg_228_1.time_ < var_231_1 + var_231_6 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play304052028 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 304052028
		arg_232_1.duration_ = 5.73

		local var_232_0 = {
			zh = 5.733,
			ja = 5.666
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play304052029(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if arg_232_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_235_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_232_1.stage_.transform)

				var_235_0.name = "1148ui_story"
				var_235_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["1148ui_story"] = var_235_0

				local var_235_1 = var_235_0:GetComponentInChildren(typeof(CharacterEffect))

				var_235_1.enabled = true

				local var_235_2 = GameObjectTools.GetOrAddComponent(var_235_0, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(false)
				end

				arg_232_1:ShowWeapon(var_235_1.transform, false)

				arg_232_1.var_["1148ui_story" .. "Animator"] = var_235_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_232_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_232_1.var_["1148ui_story" .. "LipSync"] = var_235_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action3_2")
			end

			local var_235_3 = "1148ui_story"

			if arg_232_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_235_4 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_232_1.stage_.transform)

				var_235_4.name = var_235_3
				var_235_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_[var_235_3] = var_235_4

				local var_235_5 = var_235_4:GetComponentInChildren(typeof(CharacterEffect))

				var_235_5.enabled = true

				local var_235_6 = GameObjectTools.GetOrAddComponent(var_235_4, typeof(DynamicBoneHelper))

				if var_235_6 then
					var_235_6:EnableDynamicBone(false)
				end

				arg_232_1:ShowWeapon(var_235_5.transform, false)

				arg_232_1.var_[var_235_3 .. "Animator"] = var_235_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_232_1.var_[var_235_3 .. "Animator"].applyRootMotion = true
				arg_232_1.var_[var_235_3 .. "LipSync"] = var_235_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_235_7 = arg_232_1.actors_["1148ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_7) and arg_232_1.var_.characterEffect1148ui_story == nil then
				arg_232_1.var_.characterEffect1148ui_story = var_235_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_8 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_8 and not isNil(var_235_7) then
				if arg_232_1.var_.characterEffect1148ui_story and not isNil(var_235_7) then
					arg_232_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= 0 + var_235_8 and arg_232_1.time_ < 0 + var_235_8 + arg_235_0 and not isNil(var_235_7) and arg_232_1.var_.characterEffect1148ui_story then
				arg_232_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_235_10 = 0
			local var_235_11 = 0.575

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_10 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_12 = arg_232_1:GetWordFromCfg(304052028)
				local var_235_13 = arg_232_1:FormatText(var_235_12.content)

				arg_232_1.text_.text = var_235_13

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_15 = 23 <= 0 and var_235_11 or var_235_11 * (utf8.len(var_235_13) / 23)

				if (23 <= 0 and var_235_11 or var_235_11 * (utf8.len(var_235_13) / 23)) > 0 and var_235_11 < var_235_15 then
					arg_232_1.talkMaxDuration = var_235_15

					if var_235_15 + var_235_10 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_15 + var_235_10
					end
				end

				arg_232_1.text_.text = var_235_13
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052028", "story_v_out_304052.awb") ~= 0 then
					local var_235_16 = manager.audio:GetVoiceLength("story_v_out_304052", "304052028", "story_v_out_304052.awb") / 1000

					if var_235_16 + var_235_10 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_16 + var_235_10
					end

					if var_235_12.prefab_name ~= "" and arg_232_1.actors_[var_235_12.prefab_name] ~= nil then
						local var_235_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_12.prefab_name].transform, "story_v_out_304052", "304052028", "story_v_out_304052.awb")

						arg_232_1:RecordAudio("304052028", var_235_17)
						arg_232_1:RecordAudio("304052028", var_235_17)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_304052", "304052028", "story_v_out_304052.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_304052", "304052028", "story_v_out_304052.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_18 = math.max(var_235_11, arg_232_1.talkMaxDuration)

			if var_235_10 <= arg_232_1.time_ and arg_232_1.time_ < var_235_10 + var_235_18 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_10) / var_235_18

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_10 + var_235_18 and arg_232_1.time_ < var_235_10 + var_235_18 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play304052029 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 304052029
		arg_236_1.duration_ = 5.4

		local var_236_0 = {
			zh = 5.4,
			ja = 4.9
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play304052030(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(arg_236_1.actors_["1059ui_story"]) and arg_236_1.var_.characterEffect1059ui_story == nil then
				arg_236_1.var_.characterEffect1059ui_story = arg_236_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_0 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 and not isNil(arg_236_1.actors_["1059ui_story"]) then
				if arg_236_1.var_.characterEffect1059ui_story and not isNil(arg_236_1.actors_["1059ui_story"]) then
					arg_236_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 and not isNil(arg_236_1.actors_["1059ui_story"]) and arg_236_1.var_.characterEffect1059ui_story then
				arg_236_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_239_2 = arg_236_1.actors_["1148ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.characterEffect1148ui_story == nil then
				arg_236_1.var_.characterEffect1148ui_story = var_239_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_3 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_3 and not isNil(var_239_2) then
				if arg_236_1.var_.characterEffect1148ui_story and not isNil(var_239_2) then
					arg_236_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_236_1.time_ - 0) / var_239_3)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_3 and arg_236_1.time_ < 0 + var_239_3 + arg_239_0 and not isNil(var_239_2) and arg_236_1.var_.characterEffect1148ui_story then
				arg_236_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_239_4 = 0
			local var_239_5 = 0.7

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(304052029)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_9 = 28 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 28)

				if (28 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 28)) > 0 and var_239_5 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052029", "story_v_out_304052.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_out_304052", "304052029", "story_v_out_304052.awb") / 1000

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end

					if var_239_6.prefab_name ~= "" and arg_236_1.actors_[var_239_6.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_6.prefab_name].transform, "story_v_out_304052", "304052029", "story_v_out_304052.awb")

						arg_236_1:RecordAudio("304052029", var_239_11)
						arg_236_1:RecordAudio("304052029", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_304052", "304052029", "story_v_out_304052.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_304052", "304052029", "story_v_out_304052.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_12 and arg_236_1.time_ < var_239_4 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play304052030 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 304052030
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play304052031(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["1059ui_story"]) and arg_240_1.var_.characterEffect1059ui_story == nil then
				arg_240_1.var_.characterEffect1059ui_story = arg_240_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["1059ui_story"]) then
				if arg_240_1.var_.characterEffect1059ui_story and not isNil(arg_240_1.actors_["1059ui_story"]) then
					arg_240_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_0)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["1059ui_story"]) and arg_240_1.var_.characterEffect1059ui_story then
				arg_240_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_243_1 = 0
			local var_243_2 = 0.525

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_240_1.callingController_:SetSelectedState("calling")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(304052030).content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 21 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 21)

				if (21 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 21)) > 0 and var_243_2 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_1
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_6 = math.max(var_243_2, arg_240_1.talkMaxDuration)

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_6 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_1) / var_243_6

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_1 + var_243_6 and arg_240_1.time_ < var_243_1 + var_243_6 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play304052031 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 304052031
		arg_244_1.duration_ = 5.9

		local var_244_0 = {
			zh = 5.8,
			ja = 5.9
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play304052032(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1148ui_story"]) and arg_244_1.var_.characterEffect1148ui_story == nil then
				arg_244_1.var_.characterEffect1148ui_story = arg_244_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1148ui_story"]) then
				if arg_244_1.var_.characterEffect1148ui_story and not isNil(arg_244_1.actors_["1148ui_story"]) then
					arg_244_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1148ui_story"]) and arg_244_1.var_.characterEffect1148ui_story then
				arg_244_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			local var_247_2 = 0
			local var_247_3 = 0.7

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_2 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_4 = arg_244_1:GetWordFromCfg(304052031)
				local var_247_5 = arg_244_1:FormatText(var_247_4.content)

				arg_244_1.text_.text = var_247_5

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_7 = 28 <= 0 and var_247_3 or var_247_3 * (utf8.len(var_247_5) / 28)

				if (28 <= 0 and var_247_3 or var_247_3 * (utf8.len(var_247_5) / 28)) > 0 and var_247_3 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_2
					end
				end

				arg_244_1.text_.text = var_247_5
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_304052", "304052031", "story_v_out_304052.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_304052", "304052031", "story_v_out_304052.awb") / 1000

					if var_247_8 + var_247_2 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_2
					end

					if var_247_4.prefab_name ~= "" and arg_244_1.actors_[var_247_4.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_4.prefab_name].transform, "story_v_out_304052", "304052031", "story_v_out_304052.awb")

						arg_244_1:RecordAudio("304052031", var_247_9)
						arg_244_1:RecordAudio("304052031", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_304052", "304052031", "story_v_out_304052.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_304052", "304052031", "story_v_out_304052.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_3, arg_244_1.talkMaxDuration)

			if var_247_2 <= arg_244_1.time_ and arg_244_1.time_ < var_247_2 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_2) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_2 + var_247_10 and arg_244_1.time_ < var_247_2 + var_247_10 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play304052032 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 304052032
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play304052033(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(arg_248_1.actors_["1148ui_story"]) and arg_248_1.var_.characterEffect1148ui_story == nil then
				arg_248_1.var_.characterEffect1148ui_story = arg_248_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_0 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 and not isNil(arg_248_1.actors_["1148ui_story"]) then
				if arg_248_1.var_.characterEffect1148ui_story and not isNil(arg_248_1.actors_["1148ui_story"]) then
					arg_248_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_0)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 and not isNil(arg_248_1.actors_["1148ui_story"]) and arg_248_1.var_.characterEffect1148ui_story then
				arg_248_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_251_1 = 0
			local var_251_2 = 0.4

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_248_1.callingController_:SetSelectedState("calling")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_3 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(304052032).content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 16 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 16)

				if (16 <= 0 and var_251_2 or var_251_2 * (utf8.len(var_251_3) / 16)) > 0 and var_251_2 < var_251_5 then
					arg_248_1.talkMaxDuration = var_251_5

					if var_251_5 + var_251_1 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + var_251_1
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_6 = math.max(var_251_2, arg_248_1.talkMaxDuration)

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_6 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_1) / var_251_6

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_1 + var_251_6 and arg_248_1.time_ < var_251_1 + var_251_6 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04a",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/S0104"
	},
	voices = {
		"story_v_out_304052.awb"
	}
}
