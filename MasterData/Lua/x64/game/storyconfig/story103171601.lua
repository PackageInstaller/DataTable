return {
	Play317161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play317161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STwhite == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_4_0.name = "STwhite"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STwhite = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STwhite

				arg_1_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = 2
			local var_4_12 = 0.825

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(317161001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 33 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 33)

				if (33 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 33)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play317161002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 317161002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play317161003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.025

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

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(317161002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 41 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 41)

				if (41 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 41)) > 0 and var_11_0 < var_11_3 then
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
	Play317161003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 317161003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play317161004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.5

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

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(317161003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 20 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 20)

				if (20 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 20)) > 0 and var_15_0 < var_15_3 then
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
	Play317161004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 317161004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play317161005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.175

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(317161004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 7 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 7)

				if (7 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 7)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play317161005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 317161005
		arg_20_1.duration_ = 7.57

		local var_20_0 = {
			zh = 7.566,
			ja = 7.066
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
				arg_20_0:Play317161006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1058ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1058ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1058ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1058ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1058ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1058ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1058ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1058ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1058ui_story = var_23_3.localPosition
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_20_1.time_ - 0) / var_23_4)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0, -0.95, -5.88)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			local var_23_5 = arg_20_1.actors_["1058ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1058ui_story == nil then
				arg_20_1.var_.characterEffect1058ui_story = var_23_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.characterEffect1058ui_story and not isNil(var_23_5) then
					arg_20_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.characterEffect1058ui_story then
				arg_20_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_23_8 = 0
			local var_23_9 = 0.9

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(317161005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 36 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 36)

				if (36 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 36)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161005", "story_v_out_317161.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_317161", "317161005", "story_v_out_317161.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_out_317161", "317161005", "story_v_out_317161.awb")

						arg_20_1:RecordAudio("317161005", var_23_15)
						arg_20_1:RecordAudio("317161005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_317161", "317161005", "story_v_out_317161.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_317161", "317161005", "story_v_out_317161.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_16 and arg_20_1.time_ < var_23_8 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play317161006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 317161006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play317161007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) and arg_24_1.var_.characterEffect1058ui_story == nil then
				arg_24_1.var_.characterEffect1058ui_story = arg_24_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) then
				if arg_24_1.var_.characterEffect1058ui_story and not isNil(arg_24_1.actors_["1058ui_story"]) then
					arg_24_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1058ui_story"]) and arg_24_1.var_.characterEffect1058ui_story then
				arg_24_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 0.1

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(317161006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 4 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 4)

				if (4 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 4)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play317161007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 317161007
		arg_28_1.duration_ = 4

		local var_28_0 = {
			zh = 3.3,
			ja = 4
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
				arg_28_0:Play317161008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1058ui_story = arg_28_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).z)
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles = arg_28_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_28_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1058ui_story"].transform.position).z)
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1058ui_story"].transform.localEulerAngles = arg_28_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1058ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1058ui_story == nil then
				arg_28_1.var_.characterEffect1058ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect1058ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1058ui_story then
				arg_28_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action4_2")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_4 = 0
			local var_31_5 = 0.35

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(317161007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 14 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 14)

				if (14 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 14)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161007", "story_v_out_317161.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_317161", "317161007", "story_v_out_317161.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_317161", "317161007", "story_v_out_317161.awb")

						arg_28_1:RecordAudio("317161007", var_31_11)
						arg_28_1:RecordAudio("317161007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_317161", "317161007", "story_v_out_317161.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_317161", "317161007", "story_v_out_317161.awb")
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

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play317161008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 317161008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play317161009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1058ui_story"]) and arg_32_1.var_.characterEffect1058ui_story == nil then
				arg_32_1.var_.characterEffect1058ui_story = arg_32_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1058ui_story"]) then
				if arg_32_1.var_.characterEffect1058ui_story and not isNil(arg_32_1.actors_["1058ui_story"]) then
					arg_32_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1058ui_story"]) and arg_32_1.var_.characterEffect1058ui_story then
				arg_32_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.2

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(317161008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 8 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 8)

				if (8 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 8)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play317161009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 317161009
		arg_36_1.duration_ = 6.63

		local var_36_0 = {
			zh = 6.633,
			ja = 6.3
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
				arg_36_0:Play317161010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1058ui_story = arg_36_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1058ui_story"].transform.position).z)
				arg_36_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1058ui_story"].transform.localEulerAngles = arg_36_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_36_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1058ui_story"].transform.position).z)
				arg_36_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1058ui_story"].transform.localEulerAngles = arg_36_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1058ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1058ui_story == nil then
				arg_36_1.var_.characterEffect1058ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 and not isNil(var_39_1) then
				if arg_36_1.var_.characterEffect1058ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1058ui_story then
				arg_36_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_39_4 = 0
			local var_39_5 = 0.525

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(317161009)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 21 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 21)

				if (21 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 21)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161009", "story_v_out_317161.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_317161", "317161009", "story_v_out_317161.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_317161", "317161009", "story_v_out_317161.awb")

						arg_36_1:RecordAudio("317161009", var_39_11)
						arg_36_1:RecordAudio("317161009", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_317161", "317161009", "story_v_out_317161.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_317161", "317161009", "story_v_out_317161.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play317161010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 317161010
		arg_40_1.duration_ = 1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"

			SetActive(arg_40_1.choicesGo_, true)

			for iter_41_0, iter_41_1 in ipairs(arg_40_1.choices_) do
				SetActive(iter_41_1.go, iter_41_0 <= 1)
			end

			arg_40_1.choices_[1].txt.text = arg_40_1:FormatText(StoryChoiceCfg[531].name)
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play317161011(arg_40_1)
			end

			arg_40_1:RecordChoiceLog(317161010, 531)
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1058ui_story"]) and arg_40_1.var_.characterEffect1058ui_story == nil then
				arg_40_1.var_.characterEffect1058ui_story = arg_40_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1058ui_story"]) then
				if arg_40_1.var_.characterEffect1058ui_story and not isNil(arg_40_1.actors_["1058ui_story"]) then
					arg_40_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1058ui_story"]) and arg_40_1.var_.characterEffect1058ui_story then
				arg_40_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			if arg_40_1.time_ >= var_43_1 + 0.5 and arg_40_1.time_ < var_43_1 + 0.5 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play317161011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 317161011
		arg_44_1.duration_ = 12.67

		local var_44_0 = {
			zh = 9.866,
			ja = 12.666
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
				arg_44_0:Play317161012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1058ui_story = arg_44_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1058ui_story"].transform.position).z)
				arg_44_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1058ui_story"].transform.localEulerAngles = arg_44_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_44_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1058ui_story"].transform.position).z)
				arg_44_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1058ui_story"].transform.localEulerAngles = arg_44_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1058ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1058ui_story == nil then
				arg_44_1.var_.characterEffect1058ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1058ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1058ui_story then
				arg_44_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action6_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_47_4 = 0
			local var_47_5 = 1.075

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(317161011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 43 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 43)

				if (43 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 43)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161011", "story_v_out_317161.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_317161", "317161011", "story_v_out_317161.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_317161", "317161011", "story_v_out_317161.awb")

						arg_44_1:RecordAudio("317161011", var_47_11)
						arg_44_1:RecordAudio("317161011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_317161", "317161011", "story_v_out_317161.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_317161", "317161011", "story_v_out_317161.awb")
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
				actorName = "1058ui_story",
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
	Play317161012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 317161012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play317161013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1058ui_story"]) and arg_48_1.var_.characterEffect1058ui_story == nil then
				arg_48_1.var_.characterEffect1058ui_story = arg_48_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1058ui_story"]) then
				if arg_48_1.var_.characterEffect1058ui_story and not isNil(arg_48_1.actors_["1058ui_story"]) then
					arg_48_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1058ui_story"]) and arg_48_1.var_.characterEffect1058ui_story then
				arg_48_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(317161012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 20 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 20)

				if (20 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 20)) > 0 and var_51_2 < var_51_5 then
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
	Play317161013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 317161013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play317161014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.525

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
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

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(317161013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 21 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 21)

				if (21 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 21)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play317161014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 317161014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play317161015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.475

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(317161014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 19 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 19)

				if (19 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 19)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play317161015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 317161015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play317161016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_63_0 = 0
			local var_63_1 = 0.525

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(317161015).content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 21 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_2) / 21)

				if (21 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_2) / 21)) > 0 and var_63_1 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_5 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_5 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_5

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_5 and arg_60_1.time_ < var_63_0 + var_63_5 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play317161016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 317161016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play317161017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_buildinghit02", "")
			end

			local var_67_1 = arg_64_1.actors_["1058ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1058ui_story = var_67_1.localPosition
			end

			local var_67_2 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 then
				var_67_1.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_2)
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
			local var_67_4 = 0.8

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

				local var_67_5 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(317161016).content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 32 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 32)

				if (32 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 32)) > 0 and var_67_4 < var_67_7 then
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
				actorName = "1058ui_story",
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
	Play317161017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 317161017
		arg_68_1.duration_ = 5.2

		local var_68_0 = {
			zh = 5.2,
			ja = 4.066
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
				arg_68_0:Play317161018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1058ui_story = arg_68_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1058ui_story"].transform.position).z)
				arg_68_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1058ui_story"].transform.localEulerAngles = arg_68_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_68_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1058ui_story"].transform.position).z)
				arg_68_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1058ui_story"].transform.localEulerAngles = arg_68_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_71_1 = arg_68_1.actors_["1058ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1058ui_story == nil then
				arg_68_1.var_.characterEffect1058ui_story = var_71_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 and not isNil(var_71_1) then
				if arg_68_1.var_.characterEffect1058ui_story and not isNil(var_71_1) then
					arg_68_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1058ui_story then
				arg_68_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_71_4 = 0
			local var_71_5 = 0.45

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(317161017)
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

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161017", "story_v_out_317161.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_317161", "317161017", "story_v_out_317161.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_317161", "317161017", "story_v_out_317161.awb")

						arg_68_1:RecordAudio("317161017", var_71_11)
						arg_68_1:RecordAudio("317161017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_317161", "317161017", "story_v_out_317161.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_317161", "317161017", "story_v_out_317161.awb")
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

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play317161018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 317161018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play317161019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1058ui_story"]) and arg_72_1.var_.characterEffect1058ui_story == nil then
				arg_72_1.var_.characterEffect1058ui_story = arg_72_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1058ui_story"]) then
				if arg_72_1.var_.characterEffect1058ui_story and not isNil(arg_72_1.actors_["1058ui_story"]) then
					arg_72_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1058ui_story"]) and arg_72_1.var_.characterEffect1058ui_story then
				arg_72_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.55

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(317161018).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 22 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 22)

				if (22 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 22)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play317161019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 317161019
		arg_76_1.duration_ = 8.43

		local var_76_0 = {
			zh = 6.5,
			ja = 8.433
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
				arg_76_0:Play317161020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1058ui_story = arg_76_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_79_0 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				arg_76_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1058ui_story"].transform.position).z)
				arg_76_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1058ui_story"].transform.localEulerAngles = arg_76_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				arg_76_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_76_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["1058ui_story"].transform.position).z)
				arg_76_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["1058ui_story"].transform.localEulerAngles = arg_76_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_79_1 = arg_76_1.actors_["1058ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1058ui_story == nil then
				arg_76_1.var_.characterEffect1058ui_story = var_79_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_2 and not isNil(var_79_1) then
				if arg_76_1.var_.characterEffect1058ui_story and not isNil(var_79_1) then
					arg_76_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_2 and arg_76_1.time_ < 0 + var_79_2 + arg_79_0 and not isNil(var_79_1) and arg_76_1.var_.characterEffect1058ui_story then
				arg_76_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_79_4 = 0
			local var_79_5 = 0.75

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_6 = arg_76_1:GetWordFromCfg(317161019)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 30 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 30)

				if (30 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 30)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161019", "story_v_out_317161.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_317161", "317161019", "story_v_out_317161.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_317161", "317161019", "story_v_out_317161.awb")

						arg_76_1:RecordAudio("317161019", var_79_11)
						arg_76_1:RecordAudio("317161019", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_317161", "317161019", "story_v_out_317161.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_317161", "317161019", "story_v_out_317161.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play317161020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 317161020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play317161021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1058ui_story"]) and arg_80_1.var_.characterEffect1058ui_story == nil then
				arg_80_1.var_.characterEffect1058ui_story = arg_80_1.actors_["1058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1058ui_story"]) then
				if arg_80_1.var_.characterEffect1058ui_story and not isNil(arg_80_1.actors_["1058ui_story"]) then
					arg_80_1.var_.characterEffect1058ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1058ui_story"]) and arg_80_1.var_.characterEffect1058ui_story then
				arg_80_1.var_.characterEffect1058ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1058ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.125

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
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

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(317161020).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 5 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 5)

				if (5 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 5)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play317161021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 317161021
		arg_84_1.duration_ = 5.63

		local var_84_0 = {
			zh = 4.966,
			ja = 5.633
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
				arg_84_0:Play317161022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1058ui_story = arg_84_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1058ui_story"].transform.position).z)
				arg_84_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1058ui_story"].transform.localEulerAngles = arg_84_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_84_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1058ui_story"].transform.position).z)
				arg_84_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1058ui_story"].transform.localEulerAngles = arg_84_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["1058ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1058ui_story == nil then
				arg_84_1.var_.characterEffect1058ui_story = var_87_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 and not isNil(var_87_1) then
				if arg_84_1.var_.characterEffect1058ui_story and not isNil(var_87_1) then
					arg_84_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 and not isNil(var_87_1) and arg_84_1.var_.characterEffect1058ui_story then
				arg_84_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action2_2")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_4 = 0
			local var_87_5 = 0.575

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_6 = arg_84_1:GetWordFromCfg(317161021)
				local var_87_7 = arg_84_1:FormatText(var_87_6.content)

				arg_84_1.text_.text = var_87_7

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_9 = 23 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 23)

				if (23 <= 0 and var_87_5 or var_87_5 * (utf8.len(var_87_7) / 23)) > 0 and var_87_5 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_4
					end
				end

				arg_84_1.text_.text = var_87_7
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161021", "story_v_out_317161.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_317161", "317161021", "story_v_out_317161.awb") / 1000

					if var_87_10 + var_87_4 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_4
					end

					if var_87_6.prefab_name ~= "" and arg_84_1.actors_[var_87_6.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_6.prefab_name].transform, "story_v_out_317161", "317161021", "story_v_out_317161.awb")

						arg_84_1:RecordAudio("317161021", var_87_11)
						arg_84_1:RecordAudio("317161021", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_317161", "317161021", "story_v_out_317161.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_317161", "317161021", "story_v_out_317161.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_5, arg_84_1.talkMaxDuration)

			if var_87_4 <= arg_84_1.time_ and arg_84_1.time_ < var_87_4 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_4) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_4 + var_87_12 and arg_84_1.time_ < var_87_4 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play317161022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 317161022
		arg_88_1.duration_ = 18.43

		local var_88_0 = {
			zh = 10.166,
			ja = 18.433
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
				arg_88_0:Play317161023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.1

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:GetWordFromCfg(317161022)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 44 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 44)

				if (44 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 44)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161022", "story_v_out_317161.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161022", "story_v_out_317161.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_317161", "317161022", "story_v_out_317161.awb")

						arg_88_1:RecordAudio("317161022", var_91_6)
						arg_88_1:RecordAudio("317161022", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_317161", "317161022", "story_v_out_317161.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_317161", "317161022", "story_v_out_317161.awb")
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
	Play317161023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 317161023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play317161024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1058ui_story = arg_92_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 then
				arg_92_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_0)
				arg_92_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1058ui_story"].transform.position).z)
				arg_92_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1058ui_story"].transform.localEulerAngles = arg_92_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1058ui_story"].transform.position).z)
				arg_92_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1058ui_story"].transform.localEulerAngles = arg_92_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_95_1 = 0
			local var_95_2 = 0.475

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(317161023).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 19 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 19)

				if (19 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 19)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play317161024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 317161024
		arg_96_1.duration_ = 12

		local var_96_0 = {
			zh = 9,
			ja = 12
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
				arg_96_0:Play317161025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1058ui_story = arg_96_1.actors_["1058ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1058ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1058ui_story, Vector3.New(0, -0.95, -5.88), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1058ui_story"].transform.position).z)
				arg_96_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1058ui_story"].transform.localEulerAngles = arg_96_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1058ui_story"].transform.localPosition = Vector3.New(0, -0.95, -5.88)
				arg_96_1.actors_["1058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1058ui_story"].transform.position).z)
				arg_96_1.actors_["1058ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1058ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1058ui_story"].transform.localEulerAngles = arg_96_1.actors_["1058ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1058ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1058ui_story == nil then
				arg_96_1.var_.characterEffect1058ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1058ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1058ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1058ui_story then
				arg_96_1.var_.characterEffect1058ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/story1058/story1058action/1058action1_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_99_4 = 0
			local var_99_5 = 1.175

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_6 = arg_96_1:GetWordFromCfg(317161024)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 47 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 47)

				if (47 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 47)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161024", "story_v_out_317161.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_317161", "317161024", "story_v_out_317161.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_317161", "317161024", "story_v_out_317161.awb")

						arg_96_1:RecordAudio("317161024", var_99_11)
						arg_96_1:RecordAudio("317161024", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_317161", "317161024", "story_v_out_317161.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_317161", "317161024", "story_v_out_317161.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play317161025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 317161025
		arg_100_1.duration_ = 11.43

		local var_100_0 = {
			zh = 4.933,
			ja = 11.433
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
				arg_100_0:Play317161026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.65

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[92].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:GetWordFromCfg(317161025)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 26 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 26)

				if (26 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 26)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161025", "story_v_out_317161.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161025", "story_v_out_317161.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_317161", "317161025", "story_v_out_317161.awb")

						arg_100_1:RecordAudio("317161025", var_103_6)
						arg_100_1:RecordAudio("317161025", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_317161", "317161025", "story_v_out_317161.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_317161", "317161025", "story_v_out_317161.awb")
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
	Play317161026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 317161026
		arg_104_1.duration_ = 7

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play317161027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if arg_104_1.bgs_.STblack == nil then
				local var_107_0 = Object.Instantiate(arg_104_1.paintGo_)

				var_107_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_107_0.name = "STblack"
				var_107_0.transform.parent = arg_104_1.stage_.transform
				var_107_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.bgs_.STblack = var_107_0
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				local var_107_1 = arg_104_1.bgs_.STblack

				arg_104_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_107_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_107_2 = var_107_1:GetComponent("SpriteRenderer")

				if var_107_2 and var_107_2.sprite then
					local var_107_3 = 2 * (var_107_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_107_1.transform.localScale = Vector3.New(var_107_3 / var_107_2.sprite.bounds.size.y < var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x and var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x or var_107_3 / var_107_2.sprite.bounds.size.y, var_107_3 / var_107_2.sprite.bounds.size.y < var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x and var_107_3 * manager.ui.mainCameraCom_.aspect / var_107_2.sprite.bounds.size.x or var_107_3 / var_107_2.sprite.bounds.size.y, 0)
				end

				for iter_107_0, iter_107_1 in pairs(arg_104_1.bgs_) do
					if iter_107_0 ~= "STblack" then
						iter_107_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_107_4 = 0

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_5 = 2

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_5 then
				local var_107_6 = Color.New(0, 0, 0)

				var_107_6.a = Mathf.Lerp(1, 0, (arg_104_1.time_ - var_107_4) / var_107_5)
				arg_104_1.mask_.color = var_107_6
			end

			if arg_104_1.time_ >= var_107_4 + var_107_5 and arg_104_1.time_ < var_107_4 + var_107_5 + arg_107_0 then
				local var_107_7 = Color.New(0, 0, 0)

				arg_104_1.mask_.enabled = false
				var_107_7.a = 0
				arg_104_1.mask_.color = var_107_7
			end

			local var_107_8 = arg_104_1.actors_["1058ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1058ui_story = var_107_8.localPosition
			end

			local var_107_9 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_9 then
				var_107_8.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1058ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_9)
				var_107_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_8.position).x, (manager.ui.mainCamera.transform.position - var_107_8.position).y, (manager.ui.mainCamera.transform.position - var_107_8.position).z)
				var_107_8.localEulerAngles.z = 0
				var_107_8.localEulerAngles.x = 0
				var_107_8.localEulerAngles = var_107_8.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_9 and arg_104_1.time_ < 0 + var_107_9 + arg_107_0 then
				var_107_8.localPosition = Vector3.New(0, 100, 0)
				var_107_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_8.position).x, (manager.ui.mainCamera.transform.position - var_107_8.position).y, (manager.ui.mainCamera.transform.position - var_107_8.position).z)
				var_107_8.localEulerAngles.z = 0
				var_107_8.localEulerAngles.x = 0
				var_107_8.localEulerAngles = var_107_8.localEulerAngles
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_broken", "")
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_11 = 2
			local var_107_12 = 0.65

			if 2 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_13 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_13:setOnUpdate(LuaHelper.FloatAction(function(arg_108_0)
					arg_104_1.dialogCg_.alpha = arg_108_0
				end))
				var_107_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_14 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(317161026).content)

				arg_104_1.text_.text = var_107_14

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_16 = 26 <= 0 and var_107_12 or var_107_12 * (utf8.len(var_107_14) / 26)

				if (26 <= 0 and var_107_12 or var_107_12 * (utf8.len(var_107_14) / 26)) > 0 and var_107_12 < var_107_16 then
					arg_104_1.talkMaxDuration = var_107_16
					var_107_11 = var_107_11 + 0.3

					if var_107_16 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_16 + var_107_11
					end
				end

				arg_104_1.text_.text = var_107_14
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_17 = var_107_11 + 0.3
			local var_107_18 = math.max(var_107_12, arg_104_1.talkMaxDuration)

			if var_107_11 + 0.3 <= arg_104_1.time_ and arg_104_1.time_ < var_107_17 + var_107_18 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_17) / var_107_18

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_17 + var_107_18 and arg_104_1.time_ < var_107_17 + var_107_18 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1058ui_story",
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
	Play317161027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 317161027
		arg_110_1.duration_ = 11.17

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play317161028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.bgs_.K11f == nil then
				local var_113_0 = Object.Instantiate(arg_110_1.paintGo_)

				var_113_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11f")
				var_113_0.name = "K11f"
				var_113_0.transform.parent = arg_110_1.stage_.transform
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.bgs_.K11f = var_113_0
			end

			if 3 < arg_110_1.time_ and arg_110_1.time_ <= 3 + arg_113_0 then
				local var_113_1 = arg_110_1.bgs_.K11f

				arg_110_1.bgs_.K11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_113_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_113_2 = var_113_1:GetComponent("SpriteRenderer")

				if var_113_2 and var_113_2.sprite then
					local var_113_3 = 2 * (var_113_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_113_1.transform.localScale = Vector3.New(var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, var_113_3 / var_113_2.sprite.bounds.size.y < var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x and var_113_3 * manager.ui.mainCameraCom_.aspect / var_113_2.sprite.bounds.size.x or var_113_3 / var_113_2.sprite.bounds.size.y, 0)
				end

				for iter_113_0, iter_113_1 in pairs(arg_110_1.bgs_) do
					if iter_113_0 ~= "K11f" then
						iter_113_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_113_4 = 0

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_5 = 3

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_5 then
				local var_113_6 = Color.New(0, 0, 0)

				var_113_6.a = Mathf.Lerp(0, 1, (arg_110_1.time_ - var_113_4) / var_113_5)
				arg_110_1.mask_.color = var_113_6
			end

			if arg_110_1.time_ >= var_113_4 + var_113_5 and arg_110_1.time_ < var_113_4 + var_113_5 + arg_113_0 then
				local var_113_7 = Color.New(0, 0, 0)

				var_113_7.a = 1
				arg_110_1.mask_.color = var_113_7
			end

			local var_113_8 = 3

			if 3 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.mask_.enabled = true
				arg_110_1.mask_.raycastTarget = true

				arg_110_1:SetGaussion(false)
			end

			local var_113_9 = 3.166667

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_9 then
				local var_113_10 = Color.New(0, 0, 0)

				var_113_10.a = Mathf.Lerp(1, 0, (arg_110_1.time_ - var_113_8) / var_113_9)
				arg_110_1.mask_.color = var_113_10
			end

			if arg_110_1.time_ >= var_113_8 + var_113_9 and arg_110_1.time_ < var_113_8 + var_113_9 + arg_113_0 then
				local var_113_11 = Color.New(0, 0, 0)

				arg_110_1.mask_.enabled = false
				var_113_11.a = 0
				arg_110_1.mask_.color = var_113_11
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_113_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_110_1.bgmTxt_.text ~= var_113_14 and arg_110_1.bgmTxt_.text ~= "" then
						if arg_110_1.bgmTxt2_.text ~= "" then
							arg_110_1.bgmTxt_.text = arg_110_1.bgmTxt2_.text
						end

						arg_110_1.bgmTxt2_.text = var_113_14

						arg_110_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_110_1.bgmTxt_.text = var_113_14
						arg_110_1.bgmTxt2_.text = var_113_14
					end

					if arg_110_1.bgmTimer then
						arg_110_1.bgmTimer:Stop()

						arg_110_1.bgmTimer = nil
					end

					if arg_110_1.settingData.show_music_name == 1 then
						arg_110_1.musicController:SetSelectedState("show")
						arg_110_1.musicAnimator_:Play("open", 0, 0)

						if arg_110_1.settingData.music_time ~= 0 then
							arg_110_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_110_1.settingData.music_time), function()
								if arg_110_1 == nil or isNil(arg_110_1.bgmTxt_) then
									return
								end

								arg_110_1.musicController:SetSelectedState("hide")
								arg_110_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_110_1.time_ and arg_110_1.time_ <= 0.466666666666667 + arg_113_0 then
				arg_110_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_113_17 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_110_1.bgmTxt_.text ~= var_113_17 and arg_110_1.bgmTxt_.text ~= "" then
						if arg_110_1.bgmTxt2_.text ~= "" then
							arg_110_1.bgmTxt_.text = arg_110_1.bgmTxt2_.text
						end

						arg_110_1.bgmTxt2_.text = var_113_17

						arg_110_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_110_1.bgmTxt_.text = var_113_17
						arg_110_1.bgmTxt2_.text = var_113_17
					end

					if arg_110_1.bgmTimer then
						arg_110_1.bgmTimer:Stop()

						arg_110_1.bgmTimer = nil
					end

					if arg_110_1.settingData.show_music_name == 1 then
						arg_110_1.musicController:SetSelectedState("show")
						arg_110_1.musicAnimator_:Play("open", 0, 0)

						if arg_110_1.settingData.music_time ~= 0 then
							arg_110_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_110_1.settingData.music_time), function()
								if arg_110_1 == nil or isNil(arg_110_1.bgmTxt_) then
									return
								end

								arg_110_1.musicController:SetSelectedState("hide")
								arg_110_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_110_1.frameCnt_ <= 1 then
				arg_110_1.dialog_:SetActive(false)
			end

			local var_113_18 = 6.166667
			local var_113_19 = 1.175

			if 6.166667 < arg_110_1.time_ and arg_110_1.time_ <= var_113_18 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0

				arg_110_1.dialog_:SetActive(true)

				arg_110_1.dialogCg_.alpha = 0

				local var_113_20 = LeanTween.value(arg_110_1.dialog_, 0, 1, 0.3)

				var_113_20:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_110_1.dialogCg_.alpha = arg_116_0
				end))
				var_113_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_110_1.dialog_)
					var_113_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_110_1.duration_ = arg_110_1.duration_ + 0.3

				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_21 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(317161027).content)

				arg_110_1.text_.text = var_113_21

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_23 = 47 <= 0 and var_113_19 or var_113_19 * (utf8.len(var_113_21) / 47)

				if (47 <= 0 and var_113_19 or var_113_19 * (utf8.len(var_113_21) / 47)) > 0 and var_113_19 < var_113_23 then
					arg_110_1.talkMaxDuration = var_113_23
					var_113_18 = var_113_18 + 0.3

					if var_113_23 + var_113_18 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_23 + var_113_18
					end
				end

				arg_110_1.text_.text = var_113_21
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_24 = var_113_18 + 0.3
			local var_113_25 = math.max(var_113_19, arg_110_1.talkMaxDuration)

			if var_113_18 + 0.3 <= arg_110_1.time_ and arg_110_1.time_ < var_113_24 + var_113_25 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_24) / var_113_25

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_24 + var_113_25 and arg_110_1.time_ < var_113_24 + var_113_25 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play317161028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 317161028
		arg_118_1.duration_ = 12.67

		local var_118_0 = {
			zh = 8.666,
			ja = 12.666
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
				arg_118_0:Play317161029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if arg_118_1.actors_["10003ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10003ui_story"))) then
				local var_121_0 = Object.Instantiate(Asset.Load("Char/" .. "10003ui_story"), arg_118_1.stage_.transform)

				var_121_0.name = "10003ui_story"
				var_121_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.actors_["10003ui_story"] = var_121_0

				local var_121_1 = var_121_0:GetComponentInChildren(typeof(CharacterEffect))

				var_121_1.enabled = true

				local var_121_2 = GameObjectTools.GetOrAddComponent(var_121_0, typeof(DynamicBoneHelper))

				if var_121_2 then
					var_121_2:EnableDynamicBone(false)
				end

				arg_118_1:ShowWeapon(var_121_1.transform, false)

				arg_118_1.var_["10003ui_story" .. "Animator"] = var_121_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_118_1.var_["10003ui_story" .. "Animator"].applyRootMotion = true
				arg_118_1.var_["10003ui_story" .. "LipSync"] = var_121_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_121_3 = arg_118_1.actors_["10003ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos10003ui_story = var_121_3.localPosition
			end

			local var_121_4 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				var_121_3.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10003ui_story, Vector3.New(0, -1.05, -5.9), (arg_118_1.time_ - 0) / var_121_4)
				var_121_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_3.position).x, (manager.ui.mainCamera.transform.position - var_121_3.position).y, (manager.ui.mainCamera.transform.position - var_121_3.position).z)
				var_121_3.localEulerAngles.z = 0
				var_121_3.localEulerAngles.x = 0
				var_121_3.localEulerAngles = var_121_3.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				var_121_3.localPosition = Vector3.New(0, -1.05, -5.9)
				var_121_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_3.position).x, (manager.ui.mainCamera.transform.position - var_121_3.position).y, (manager.ui.mainCamera.transform.position - var_121_3.position).z)
				var_121_3.localEulerAngles.z = 0
				var_121_3.localEulerAngles.x = 0
				var_121_3.localEulerAngles = var_121_3.localEulerAngles
			end

			local var_121_5 = arg_118_1.actors_["10003ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect10003ui_story == nil then
				arg_118_1.var_.characterEffect10003ui_story = var_121_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_6 and not isNil(var_121_5) then
				if arg_118_1.var_.characterEffect10003ui_story and not isNil(var_121_5) then
					arg_118_1.var_.characterEffect10003ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_6 and arg_118_1.time_ < 0 + var_121_6 + arg_121_0 and not isNil(var_121_5) and arg_118_1.var_.characterEffect10003ui_story then
				arg_118_1.var_.characterEffect10003ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/story10003/story10003action/10003action1_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("10003ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_121_8 = 0
			local var_121_9 = 0.825

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_10 = arg_118_1:GetWordFromCfg(317161028)
				local var_121_11 = arg_118_1:FormatText(var_121_10.content)

				arg_118_1.text_.text = var_121_11

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 33 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 33)

				if (33 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 33)) > 0 and var_121_9 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_11
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161028", "story_v_out_317161.awb") ~= 0 then
					local var_121_14 = manager.audio:GetVoiceLength("story_v_out_317161", "317161028", "story_v_out_317161.awb") / 1000

					if var_121_14 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_14 + var_121_8
					end

					if var_121_10.prefab_name ~= "" and arg_118_1.actors_[var_121_10.prefab_name] ~= nil then
						local var_121_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_10.prefab_name].transform, "story_v_out_317161", "317161028", "story_v_out_317161.awb")

						arg_118_1:RecordAudio("317161028", var_121_15)
						arg_118_1:RecordAudio("317161028", var_121_15)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_317161", "317161028", "story_v_out_317161.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_317161", "317161028", "story_v_out_317161.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_16 and arg_118_1.time_ < var_121_8 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play317161029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 317161029
		arg_122_1.duration_ = 4.9

		local var_122_0 = {
			zh = 3.266,
			ja = 4.9
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
				arg_122_0:Play317161030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["10003ui_story"]) and arg_122_1.var_.characterEffect10003ui_story == nil then
				arg_122_1.var_.characterEffect10003ui_story = arg_122_1.actors_["10003ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["10003ui_story"]) then
				if arg_122_1.var_.characterEffect10003ui_story and not isNil(arg_122_1.actors_["10003ui_story"]) then
					arg_122_1.var_.characterEffect10003ui_story.fillFlat = true
					arg_122_1.var_.characterEffect10003ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_0)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["10003ui_story"]) and arg_122_1.var_.characterEffect10003ui_story then
				arg_122_1.var_.characterEffect10003ui_story.fillFlat = true
				arg_122_1.var_.characterEffect10003ui_story.fillRatio = 0.5
			end

			local var_125_1 = 0
			local var_125_2 = 0.3

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:GetWordFromCfg(317161029)
				local var_125_4 = arg_122_1:FormatText(var_125_3.content)

				arg_122_1.text_.text = var_125_4

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 12 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_4) / 12)

				if (12 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_4) / 12)) > 0 and var_125_2 < var_125_6 then
					arg_122_1.talkMaxDuration = var_125_6

					if var_125_6 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_6 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_4
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161029", "story_v_out_317161.awb") ~= 0 then
					local var_125_7 = manager.audio:GetVoiceLength("story_v_out_317161", "317161029", "story_v_out_317161.awb") / 1000

					if var_125_7 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_1
					end

					if var_125_3.prefab_name ~= "" and arg_122_1.actors_[var_125_3.prefab_name] ~= nil then
						local var_125_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_3.prefab_name].transform, "story_v_out_317161", "317161029", "story_v_out_317161.awb")

						arg_122_1:RecordAudio("317161029", var_125_8)
						arg_122_1:RecordAudio("317161029", var_125_8)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_317161", "317161029", "story_v_out_317161.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_317161", "317161029", "story_v_out_317161.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_9 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_9 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_9

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_9 and arg_122_1.time_ < var_125_1 + var_125_9 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play317161030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 317161030
		arg_126_1.duration_ = 9

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play317161031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if arg_126_1.bgs_.S0609 == nil then
				local var_129_0 = Object.Instantiate(arg_126_1.paintGo_)

				var_129_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0609")
				var_129_0.name = "S0609"
				var_129_0.transform.parent = arg_126_1.stage_.transform
				var_129_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.bgs_.S0609 = var_129_0
			end

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= 2 + arg_129_0 then
				local var_129_1 = arg_126_1.bgs_.S0609

				arg_126_1.bgs_.S0609.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_129_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_2 = var_129_1:GetComponent("SpriteRenderer")

				if var_129_2 and var_129_2.sprite then
					local var_129_3 = 2 * (var_129_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_129_1.transform.localScale = Vector3.New(var_129_3 / var_129_2.sprite.bounds.size.y < var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x and var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x or var_129_3 / var_129_2.sprite.bounds.size.y, var_129_3 / var_129_2.sprite.bounds.size.y < var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x and var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x or var_129_3 / var_129_2.sprite.bounds.size.y, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "S0609" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_4 = 0

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_5 = 2

			if var_129_4 <= arg_126_1.time_ and arg_126_1.time_ < var_129_4 + var_129_5 then
				local var_129_6 = Color.New(0, 0, 0)

				var_129_6.a = Mathf.Lerp(0, 1, (arg_126_1.time_ - var_129_4) / var_129_5)
				arg_126_1.mask_.color = var_129_6
			end

			if arg_126_1.time_ >= var_129_4 + var_129_5 and arg_126_1.time_ < var_129_4 + var_129_5 + arg_129_0 then
				local var_129_7 = Color.New(0, 0, 0)

				var_129_7.a = 1
				arg_126_1.mask_.color = var_129_7
			end

			local var_129_8 = 2

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_9 = 2

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_9 then
				local var_129_10 = Color.New(0, 0, 0)

				var_129_10.a = Mathf.Lerp(1, 0, (arg_126_1.time_ - var_129_8) / var_129_9)
				arg_126_1.mask_.color = var_129_10
			end

			if arg_126_1.time_ >= var_129_8 + var_129_9 and arg_126_1.time_ < var_129_8 + var_129_9 + arg_129_0 then
				local var_129_11 = Color.New(0, 0, 0)

				arg_126_1.mask_.enabled = false
				var_129_11.a = 0
				arg_126_1.mask_.color = var_129_11
			end

			local var_129_12 = arg_126_1.actors_["10003ui_story"].transform

			if 2 < arg_126_1.time_ and arg_126_1.time_ <= 2 + arg_129_0 then
				arg_126_1.var_.moveOldPos10003ui_story = var_129_12.localPosition
			end

			local var_129_13 = 0.001

			if 2 <= arg_126_1.time_ and arg_126_1.time_ < 2 + var_129_13 then
				var_129_12.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10003ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 2) / var_129_13)
				var_129_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_12.position).x, (manager.ui.mainCamera.transform.position - var_129_12.position).y, (manager.ui.mainCamera.transform.position - var_129_12.position).z)
				var_129_12.localEulerAngles.z = 0
				var_129_12.localEulerAngles.x = 0
				var_129_12.localEulerAngles = var_129_12.localEulerAngles
			end

			if arg_126_1.time_ >= 2 + var_129_13 and arg_126_1.time_ < 2 + var_129_13 + arg_129_0 then
				var_129_12.localPosition = Vector3.New(0, 100, 0)
				var_129_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_12.position).x, (manager.ui.mainCamera.transform.position - var_129_12.position).y, (manager.ui.mainCamera.transform.position - var_129_12.position).z)
				var_129_12.localEulerAngles.z = 0
				var_129_12.localEulerAngles.x = 0
				var_129_12.localEulerAngles = var_129_12.localEulerAngles
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_14 = 4
			local var_129_15 = 1.05

			if 4 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_16 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_16:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_17 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(317161030).content)

				arg_126_1.text_.text = var_129_17

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_19 = 42 <= 0 and var_129_15 or var_129_15 * (utf8.len(var_129_17) / 42)

				if (42 <= 0 and var_129_15 or var_129_15 * (utf8.len(var_129_17) / 42)) > 0 and var_129_15 < var_129_19 then
					arg_126_1.talkMaxDuration = var_129_19
					var_129_14 = var_129_14 + 0.3

					if var_129_19 + var_129_14 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_19 + var_129_14
					end
				end

				arg_126_1.text_.text = var_129_17
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_20 = var_129_14 + 0.3
			local var_129_21 = math.max(var_129_15, arg_126_1.talkMaxDuration)

			if var_129_14 + 0.3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_20 + var_129_21 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_20) / var_129_21

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_20 + var_129_21 and arg_126_1.time_ < var_129_20 + var_129_21 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10003ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play317161031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 317161031
		arg_132_1.duration_ = 4.4

		local var_132_0 = {
			zh = 4.4,
			ja = 2.533
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
				arg_132_0:Play317161032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.425

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_1 = arg_132_1:GetWordFromCfg(317161031)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 17 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 17)

				if (17 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 17)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161031", "story_v_out_317161.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161031", "story_v_out_317161.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_317161", "317161031", "story_v_out_317161.awb")

						arg_132_1:RecordAudio("317161031", var_135_6)
						arg_132_1:RecordAudio("317161031", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_317161", "317161031", "story_v_out_317161.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_317161", "317161031", "story_v_out_317161.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play317161032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 317161032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play317161033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.9

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_1 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(317161032).content)

				arg_136_1.text_.text = var_139_1

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_3 = 36 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 36)

				if (36 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_1) / 36)) > 0 and var_139_0 < var_139_3 then
					arg_136_1.talkMaxDuration = var_139_3

					if var_139_3 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_3 + 0
					end
				end

				arg_136_1.text_.text = var_139_1
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_4 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_4

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play317161033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 317161033
		arg_140_1.duration_ = 10.47

		local var_140_0 = {
			zh = 10.466,
			ja = 9.133
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
				arg_140_0:Play317161034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 1.05

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:GetWordFromCfg(317161033)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 42 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 42)

				if (42 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 42)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161033", "story_v_out_317161.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161033", "story_v_out_317161.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_317161", "317161033", "story_v_out_317161.awb")

						arg_140_1:RecordAudio("317161033", var_143_6)
						arg_140_1:RecordAudio("317161033", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_317161", "317161033", "story_v_out_317161.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_317161", "317161033", "story_v_out_317161.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play317161034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 317161034
		arg_144_1.duration_ = 2.3

		local var_144_0 = {
			zh = 1.6,
			ja = 2.3
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play317161035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.125

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:GetWordFromCfg(317161034)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 5 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 5)

				if (5 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 5)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161034", "story_v_out_317161.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161034", "story_v_out_317161.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_317161", "317161034", "story_v_out_317161.awb")

						arg_144_1:RecordAudio("317161034", var_147_6)
						arg_144_1:RecordAudio("317161034", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_317161", "317161034", "story_v_out_317161.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_317161", "317161034", "story_v_out_317161.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play317161035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 317161035
		arg_148_1.duration_ = 3.3

		local var_148_0 = {
			zh = 2.8,
			ja = 3.3
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play317161036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.175

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(317161035)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 7 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 7)

				if (7 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 7)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161035", "story_v_out_317161.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161035", "story_v_out_317161.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_317161", "317161035", "story_v_out_317161.awb")

						arg_148_1:RecordAudio("317161035", var_151_6)
						arg_148_1:RecordAudio("317161035", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_317161", "317161035", "story_v_out_317161.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_317161", "317161035", "story_v_out_317161.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play317161036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 317161036
		arg_152_1.duration_ = 3.33

		local var_152_0 = {
			zh = 1.166,
			ja = 3.333
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play317161037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.125

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_1 = arg_152_1:GetWordFromCfg(317161036)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 5 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 5)

				if (5 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 5)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161036", "story_v_out_317161.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161036", "story_v_out_317161.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_317161", "317161036", "story_v_out_317161.awb")

						arg_152_1:RecordAudio("317161036", var_155_6)
						arg_152_1:RecordAudio("317161036", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_317161", "317161036", "story_v_out_317161.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_317161", "317161036", "story_v_out_317161.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play317161037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 317161037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play317161038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 1.325

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(317161037).content)

				arg_156_1.text_.text = var_159_1

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_3 = 53 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 53)

				if (53 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_1) / 53)) > 0 and var_159_0 < var_159_3 then
					arg_156_1.talkMaxDuration = var_159_3

					if var_159_3 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_3 + 0
					end
				end

				arg_156_1.text_.text = var_159_1
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_4 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_4

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play317161038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 317161038
		arg_160_1.duration_ = 5.2

		local var_160_0 = {
			zh = 4.1,
			ja = 5.2
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play317161039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.325

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:GetWordFromCfg(317161038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 13 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 13)

				if (13 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 13)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161038", "story_v_out_317161.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161038", "story_v_out_317161.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_317161", "317161038", "story_v_out_317161.awb")

						arg_160_1:RecordAudio("317161038", var_163_6)
						arg_160_1:RecordAudio("317161038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_317161", "317161038", "story_v_out_317161.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_317161", "317161038", "story_v_out_317161.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play317161039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 317161039
		arg_164_1.duration_ = 6.83

		local var_164_0 = {
			zh = 6.833,
			ja = 6.033
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
				arg_164_0:Play317161040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.625

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:GetWordFromCfg(317161039)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 25 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 25)

				if (25 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 25)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161039", "story_v_out_317161.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161039", "story_v_out_317161.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_317161", "317161039", "story_v_out_317161.awb")

						arg_164_1:RecordAudio("317161039", var_167_6)
						arg_164_1:RecordAudio("317161039", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_317161", "317161039", "story_v_out_317161.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_317161", "317161039", "story_v_out_317161.awb")
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
	Play317161040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 317161040
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play317161041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.35

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(317161040).content)

				arg_168_1.text_.text = var_171_1

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_3 = 14 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 14)

				if (14 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_1) / 14)) > 0 and var_171_0 < var_171_3 then
					arg_168_1.talkMaxDuration = var_171_3

					if var_171_3 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_3 + 0
					end
				end

				arg_168_1.text_.text = var_171_1
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_4 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_4 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_4

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_4 and arg_168_1.time_ < 0 + var_171_4 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play317161041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 317161041
		arg_172_1.duration_ = 14.83

		local var_172_0 = {
			zh = 14.833,
			ja = 12.433
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
				arg_172_0:Play317161042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 1.35

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:GetWordFromCfg(317161041)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 54 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 54)

				if (54 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 54)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161041", "story_v_out_317161.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161041", "story_v_out_317161.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_317161", "317161041", "story_v_out_317161.awb")

						arg_172_1:RecordAudio("317161041", var_175_6)
						arg_172_1:RecordAudio("317161041", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_317161", "317161041", "story_v_out_317161.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_317161", "317161041", "story_v_out_317161.awb")
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
	Play317161042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 317161042
		arg_176_1.duration_ = 8.1

		local var_176_0 = {
			zh = 8.1,
			ja = 4.3
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play317161043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.75

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:GetWordFromCfg(317161042)
				local var_179_2 = arg_176_1:FormatText(var_179_1.content)

				arg_176_1.text_.text = var_179_2

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 30 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 30)

				if (30 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_2) / 30)) > 0 and var_179_0 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end

				arg_176_1.text_.text = var_179_2
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161042", "story_v_out_317161.awb") ~= 0 then
					local var_179_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161042", "story_v_out_317161.awb") / 1000

					if var_179_5 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_5 + 0
					end

					if var_179_1.prefab_name ~= "" and arg_176_1.actors_[var_179_1.prefab_name] ~= nil then
						local var_179_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_1.prefab_name].transform, "story_v_out_317161", "317161042", "story_v_out_317161.awb")

						arg_176_1:RecordAudio("317161042", var_179_6)
						arg_176_1:RecordAudio("317161042", var_179_6)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_317161", "317161042", "story_v_out_317161.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_317161", "317161042", "story_v_out_317161.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_7 and arg_176_1.time_ < 0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play317161043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 317161043
		arg_180_1.duration_ = 6.2

		local var_180_0 = {
			zh = 5.133,
			ja = 6.2
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
				arg_180_0:Play317161044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.35

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_1 = arg_180_1:GetWordFromCfg(317161043)
				local var_183_2 = arg_180_1:FormatText(var_183_1.content)

				arg_180_1.text_.text = var_183_2

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 14 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 14)

				if (14 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 14)) > 0 and var_183_0 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + 0
					end
				end

				arg_180_1.text_.text = var_183_2
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161043", "story_v_out_317161.awb") ~= 0 then
					local var_183_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161043", "story_v_out_317161.awb") / 1000

					if var_183_5 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + 0
					end

					if var_183_1.prefab_name ~= "" and arg_180_1.actors_[var_183_1.prefab_name] ~= nil then
						local var_183_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_1.prefab_name].transform, "story_v_out_317161", "317161043", "story_v_out_317161.awb")

						arg_180_1:RecordAudio("317161043", var_183_6)
						arg_180_1:RecordAudio("317161043", var_183_6)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_317161", "317161043", "story_v_out_317161.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_317161", "317161043", "story_v_out_317161.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play317161044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 317161044
		arg_184_1.duration_ = 15

		local var_184_0 = {
			zh = 15,
			ja = 14.433
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
				arg_184_0:Play317161045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 1.7

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_1 = arg_184_1:GetWordFromCfg(317161044)
				local var_187_2 = arg_184_1:FormatText(var_187_1.content)

				arg_184_1.text_.text = var_187_2

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_4 = 68 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 68)

				if (68 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 68)) > 0 and var_187_0 < var_187_4 then
					arg_184_1.talkMaxDuration = var_187_4

					if var_187_4 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_4 + 0
					end
				end

				arg_184_1.text_.text = var_187_2
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161044", "story_v_out_317161.awb") ~= 0 then
					local var_187_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161044", "story_v_out_317161.awb") / 1000

					if var_187_5 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + 0
					end

					if var_187_1.prefab_name ~= "" and arg_184_1.actors_[var_187_1.prefab_name] ~= nil then
						local var_187_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_1.prefab_name].transform, "story_v_out_317161", "317161044", "story_v_out_317161.awb")

						arg_184_1:RecordAudio("317161044", var_187_6)
						arg_184_1:RecordAudio("317161044", var_187_6)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_317161", "317161044", "story_v_out_317161.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_317161", "317161044", "story_v_out_317161.awb")
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
	Play317161045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 317161045
		arg_188_1.duration_ = 6.2

		local var_188_0 = {
			zh = 6.2,
			ja = 4.433
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play317161046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.65

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:GetWordFromCfg(317161045)
				local var_191_2 = arg_188_1:FormatText(var_191_1.content)

				arg_188_1.text_.text = var_191_2

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 26 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 26)

				if (26 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_2) / 26)) > 0 and var_191_0 < var_191_4 then
					arg_188_1.talkMaxDuration = var_191_4

					if var_191_4 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_4 + 0
					end
				end

				arg_188_1.text_.text = var_191_2
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161045", "story_v_out_317161.awb") ~= 0 then
					local var_191_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161045", "story_v_out_317161.awb") / 1000

					if var_191_5 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_5 + 0
					end

					if var_191_1.prefab_name ~= "" and arg_188_1.actors_[var_191_1.prefab_name] ~= nil then
						local var_191_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_1.prefab_name].transform, "story_v_out_317161", "317161045", "story_v_out_317161.awb")

						arg_188_1:RecordAudio("317161045", var_191_6)
						arg_188_1:RecordAudio("317161045", var_191_6)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_317161", "317161045", "story_v_out_317161.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_317161", "317161045", "story_v_out_317161.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play317161046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 317161046
		arg_192_1.duration_ = 4.7

		local var_192_0 = {
			zh = 4.2,
			ja = 4.7
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play317161047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.25

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:GetWordFromCfg(317161046)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 10 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 10)

				if (10 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 10)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161046", "story_v_out_317161.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161046", "story_v_out_317161.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_317161", "317161046", "story_v_out_317161.awb")

						arg_192_1:RecordAudio("317161046", var_195_6)
						arg_192_1:RecordAudio("317161046", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_317161", "317161046", "story_v_out_317161.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_317161", "317161046", "story_v_out_317161.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play317161047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 317161047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play317161048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.7

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_1 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(317161047).content)

				arg_196_1.text_.text = var_199_1

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_3 = 28 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 28)

				if (28 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 28)) > 0 and var_199_0 < var_199_3 then
					arg_196_1.talkMaxDuration = var_199_3

					if var_199_3 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_3 + 0
					end
				end

				arg_196_1.text_.text = var_199_1
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_4 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_4

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play317161048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 317161048
		arg_200_1.duration_ = 10.4

		local var_200_0 = {
			zh = 10.4,
			ja = 10.366
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play317161049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.875

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:GetWordFromCfg(317161048)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 35 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 35)

				if (35 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 35)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161048", "story_v_out_317161.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161048", "story_v_out_317161.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_317161", "317161048", "story_v_out_317161.awb")

						arg_200_1:RecordAudio("317161048", var_203_6)
						arg_200_1:RecordAudio("317161048", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_317161", "317161048", "story_v_out_317161.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_317161", "317161048", "story_v_out_317161.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play317161049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 317161049
		arg_204_1.duration_ = 9.5

		local var_204_0 = {
			zh = 7.133,
			ja = 9.5
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play317161050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.675

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:GetWordFromCfg(317161049)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 27 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 27)

				if (27 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 27)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161049", "story_v_out_317161.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161049", "story_v_out_317161.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_317161", "317161049", "story_v_out_317161.awb")

						arg_204_1:RecordAudio("317161049", var_207_6)
						arg_204_1:RecordAudio("317161049", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_317161", "317161049", "story_v_out_317161.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_317161", "317161049", "story_v_out_317161.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play317161050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 317161050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play317161051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.525

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(317161050).content)

				arg_208_1.text_.text = var_211_1

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_3 = 21 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 21)

				if (21 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_1) / 21)) > 0 and var_211_0 < var_211_3 then
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
	Play317161051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 317161051
		arg_212_1.duration_ = 8.47

		local var_212_0 = {
			zh = 7.866,
			ja = 8.466
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
				arg_212_0:Play317161052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.825

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_1 = arg_212_1:GetWordFromCfg(317161051)
				local var_215_2 = arg_212_1:FormatText(var_215_1.content)

				arg_212_1.text_.text = var_215_2

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 33 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 33)

				if (33 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_2) / 33)) > 0 and var_215_0 < var_215_4 then
					arg_212_1.talkMaxDuration = var_215_4

					if var_215_4 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_4 + 0
					end
				end

				arg_212_1.text_.text = var_215_2
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161051", "story_v_out_317161.awb") ~= 0 then
					local var_215_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161051", "story_v_out_317161.awb") / 1000

					if var_215_5 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_5 + 0
					end

					if var_215_1.prefab_name ~= "" and arg_212_1.actors_[var_215_1.prefab_name] ~= nil then
						local var_215_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_1.prefab_name].transform, "story_v_out_317161", "317161051", "story_v_out_317161.awb")

						arg_212_1:RecordAudio("317161051", var_215_6)
						arg_212_1:RecordAudio("317161051", var_215_6)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_317161", "317161051", "story_v_out_317161.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_317161", "317161051", "story_v_out_317161.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_7 and arg_212_1.time_ < 0 + var_215_7 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play317161052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 317161052
		arg_216_1.duration_ = 13.67

		local var_216_0 = {
			zh = 13.666,
			ja = 8.766
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play317161053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 1.425

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_1 = arg_216_1:GetWordFromCfg(317161052)
				local var_219_2 = arg_216_1:FormatText(var_219_1.content)

				arg_216_1.text_.text = var_219_2

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 57 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 57)

				if (57 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 57)) > 0 and var_219_0 < var_219_4 then
					arg_216_1.talkMaxDuration = var_219_4

					if var_219_4 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_4 + 0
					end
				end

				arg_216_1.text_.text = var_219_2
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161052", "story_v_out_317161.awb") ~= 0 then
					local var_219_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161052", "story_v_out_317161.awb") / 1000

					if var_219_5 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + 0
					end

					if var_219_1.prefab_name ~= "" and arg_216_1.actors_[var_219_1.prefab_name] ~= nil then
						local var_219_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_1.prefab_name].transform, "story_v_out_317161", "317161052", "story_v_out_317161.awb")

						arg_216_1:RecordAudio("317161052", var_219_6)
						arg_216_1:RecordAudio("317161052", var_219_6)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_317161", "317161052", "story_v_out_317161.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_317161", "317161052", "story_v_out_317161.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play317161053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 317161053
		arg_220_1.duration_ = 8.07

		local var_220_0 = {
			zh = 8.066,
			ja = 7.033
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
				arg_220_0:Play317161054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.7

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_1 = arg_220_1:GetWordFromCfg(317161053)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 28 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 28)

				if (28 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 28)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161053", "story_v_out_317161.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161053", "story_v_out_317161.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_out_317161", "317161053", "story_v_out_317161.awb")

						arg_220_1:RecordAudio("317161053", var_223_6)
						arg_220_1:RecordAudio("317161053", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_317161", "317161053", "story_v_out_317161.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_317161", "317161053", "story_v_out_317161.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play317161054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 317161054
		arg_224_1.duration_ = 5

		local var_224_0 = {
			zh = 4.7,
			ja = 5
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
				arg_224_0:Play317161055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0.45

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_1 = arg_224_1:GetWordFromCfg(317161054)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 18 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 18)

				if (18 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 18)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161054", "story_v_out_317161.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161054", "story_v_out_317161.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_317161", "317161054", "story_v_out_317161.awb")

						arg_224_1:RecordAudio("317161054", var_227_6)
						arg_224_1:RecordAudio("317161054", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_317161", "317161054", "story_v_out_317161.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_317161", "317161054", "story_v_out_317161.awb")
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
	Play317161055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 317161055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play317161056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 1.025

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(317161055).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 41 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 41)

				if (41 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 41)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play317161056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 317161056
		arg_232_1.duration_ = 6.37

		local var_232_0 = {
			zh = 6.366,
			ja = 3.766
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
				arg_232_0:Play317161057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 0.675

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:GetWordFromCfg(317161056)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 27 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 27)

				if (27 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 27)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161056", "story_v_out_317161.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161056", "story_v_out_317161.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_317161", "317161056", "story_v_out_317161.awb")

						arg_232_1:RecordAudio("317161056", var_235_6)
						arg_232_1:RecordAudio("317161056", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_317161", "317161056", "story_v_out_317161.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_317161", "317161056", "story_v_out_317161.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play317161057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 317161057
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play317161058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.5

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(317161057).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 20 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 20)

				if (20 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 20)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play317161058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 317161058
		arg_240_1.duration_ = 4.4

		local var_240_0 = {
			zh = 2.1,
			ja = 4.4
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play317161059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.225

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:GetWordFromCfg(317161058)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 9 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 9)

				if (9 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 9)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161058", "story_v_out_317161.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161058", "story_v_out_317161.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_317161", "317161058", "story_v_out_317161.awb")

						arg_240_1:RecordAudio("317161058", var_243_6)
						arg_240_1:RecordAudio("317161058", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_317161", "317161058", "story_v_out_317161.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_317161", "317161058", "story_v_out_317161.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play317161059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 317161059
		arg_244_1.duration_ = 2.27

		local var_244_0 = {
			zh = 1.033,
			ja = 2.266
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
				arg_244_0:Play317161060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.05

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:GetWordFromCfg(317161059)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 2 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 2)

				if (2 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 2)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161059", "story_v_out_317161.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161059", "story_v_out_317161.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_317161", "317161059", "story_v_out_317161.awb")

						arg_244_1:RecordAudio("317161059", var_247_6)
						arg_244_1:RecordAudio("317161059", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_317161", "317161059", "story_v_out_317161.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_317161", "317161059", "story_v_out_317161.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play317161060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 317161060
		arg_248_1.duration_ = 8.4

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play317161061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.875

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, true)
				arg_248_1.iconController_:SetSelectedState("hero")

				arg_248_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_248_1.callingController_:SetSelectedState("normal")

				arg_248_1.keyicon_.color = Color.New(1, 1, 1)
				arg_248_1.icon_.color = Color.New(1, 1, 1)

				local var_251_1 = arg_248_1:GetWordFromCfg(317161060)
				local var_251_2 = arg_248_1:FormatText(var_251_1.content)

				arg_248_1.text_.text = var_251_2

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 35 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 35)

				if (35 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_2) / 35)) > 0 and var_251_0 < var_251_4 then
					arg_248_1.talkMaxDuration = var_251_4

					if var_251_4 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_4 + 0
					end
				end

				arg_248_1.text_.text = var_251_2
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161060", "story_v_out_317161.awb") ~= 0 then
					local var_251_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161060", "story_v_out_317161.awb") / 1000

					if var_251_5 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_5 + 0
					end

					if var_251_1.prefab_name ~= "" and arg_248_1.actors_[var_251_1.prefab_name] ~= nil then
						local var_251_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_1.prefab_name].transform, "story_v_out_317161", "317161060", "story_v_out_317161.awb")

						arg_248_1:RecordAudio("317161060", var_251_6)
						arg_248_1:RecordAudio("317161060", var_251_6)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_317161", "317161060", "story_v_out_317161.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_317161", "317161060", "story_v_out_317161.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_7 and arg_248_1.time_ < 0 + var_251_7 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play317161061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 317161061
		arg_252_1.duration_ = 8.97

		local var_252_0 = {
			zh = 8.966,
			ja = 6.766
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play317161062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 1.05

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:GetWordFromCfg(317161061)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 42 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 42)

				if (42 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 42)) > 0 and var_255_0 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + 0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161061", "story_v_out_317161.awb") ~= 0 then
					local var_255_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161061", "story_v_out_317161.awb") / 1000

					if var_255_5 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + 0
					end

					if var_255_1.prefab_name ~= "" and arg_252_1.actors_[var_255_1.prefab_name] ~= nil then
						local var_255_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_1.prefab_name].transform, "story_v_out_317161", "317161061", "story_v_out_317161.awb")

						arg_252_1:RecordAudio("317161061", var_255_6)
						arg_252_1:RecordAudio("317161061", var_255_6)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_317161", "317161061", "story_v_out_317161.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_317161", "317161061", "story_v_out_317161.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play317161062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 317161062
		arg_256_1.duration_ = 3.9

		local var_256_0 = {
			zh = 3.9,
			ja = 2.466
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play317161063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.425

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_1 = arg_256_1:GetWordFromCfg(317161062)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 17 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 17)

				if (17 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 17)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161062", "story_v_out_317161.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161062", "story_v_out_317161.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_317161", "317161062", "story_v_out_317161.awb")

						arg_256_1:RecordAudio("317161062", var_259_6)
						arg_256_1:RecordAudio("317161062", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_317161", "317161062", "story_v_out_317161.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_317161", "317161062", "story_v_out_317161.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play317161063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 317161063
		arg_260_1.duration_ = 5.93

		local var_260_0 = {
			zh = 5.4,
			ja = 5.933
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play317161064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.325

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(317161063)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 13 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 13)

				if (13 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 13)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161063", "story_v_out_317161.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161063", "story_v_out_317161.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_317161", "317161063", "story_v_out_317161.awb")

						arg_260_1:RecordAudio("317161063", var_263_6)
						arg_260_1:RecordAudio("317161063", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_317161", "317161063", "story_v_out_317161.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_317161", "317161063", "story_v_out_317161.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play317161064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 317161064
		arg_264_1.duration_ = 3.87

		local var_264_0 = {
			zh = 1.166,
			ja = 3.866
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play317161065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.075

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:GetWordFromCfg(317161064)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 3 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 3)

				if (3 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 3)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161064", "story_v_out_317161.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161064", "story_v_out_317161.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_317161", "317161064", "story_v_out_317161.awb")

						arg_264_1:RecordAudio("317161064", var_267_6)
						arg_264_1:RecordAudio("317161064", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_317161", "317161064", "story_v_out_317161.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_317161", "317161064", "story_v_out_317161.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play317161065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 317161065
		arg_268_1.duration_ = 12.23

		local var_268_0 = {
			zh = 12.233,
			ja = 8.5
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play317161066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 1.175

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:GetWordFromCfg(317161065)
				local var_271_2 = arg_268_1:FormatText(var_271_1.content)

				arg_268_1.text_.text = var_271_2

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_4 = 47 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 47)

				if (47 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_2) / 47)) > 0 and var_271_0 < var_271_4 then
					arg_268_1.talkMaxDuration = var_271_4

					if var_271_4 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_4 + 0
					end
				end

				arg_268_1.text_.text = var_271_2
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161065", "story_v_out_317161.awb") ~= 0 then
					local var_271_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161065", "story_v_out_317161.awb") / 1000

					if var_271_5 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + 0
					end

					if var_271_1.prefab_name ~= "" and arg_268_1.actors_[var_271_1.prefab_name] ~= nil then
						local var_271_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_1.prefab_name].transform, "story_v_out_317161", "317161065", "story_v_out_317161.awb")

						arg_268_1:RecordAudio("317161065", var_271_6)
						arg_268_1:RecordAudio("317161065", var_271_6)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_317161", "317161065", "story_v_out_317161.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_317161", "317161065", "story_v_out_317161.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_7 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_7

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play317161066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 317161066
		arg_272_1.duration_ = 2.8

		local var_272_0 = {
			zh = 2.8,
			ja = 1.933
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play317161067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.2

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:GetWordFromCfg(317161066)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 7 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 7)

				if (7 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 7)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161066", "story_v_out_317161.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161066", "story_v_out_317161.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_317161", "317161066", "story_v_out_317161.awb")

						arg_272_1:RecordAudio("317161066", var_275_6)
						arg_272_1:RecordAudio("317161066", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_317161", "317161066", "story_v_out_317161.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_317161", "317161066", "story_v_out_317161.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play317161067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 317161067
		arg_276_1.duration_ = 9.07

		local var_276_0 = {
			zh = 9.066,
			ja = 7.733
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play317161068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.9

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[559].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_1 = arg_276_1:GetWordFromCfg(317161067)
				local var_279_2 = arg_276_1:FormatText(var_279_1.content)

				arg_276_1.text_.text = var_279_2

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_4 = 36 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 36)

				if (36 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_2) / 36)) > 0 and var_279_0 < var_279_4 then
					arg_276_1.talkMaxDuration = var_279_4

					if var_279_4 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_4 + 0
					end
				end

				arg_276_1.text_.text = var_279_2
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161067", "story_v_out_317161.awb") ~= 0 then
					local var_279_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161067", "story_v_out_317161.awb") / 1000

					if var_279_5 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + 0
					end

					if var_279_1.prefab_name ~= "" and arg_276_1.actors_[var_279_1.prefab_name] ~= nil then
						local var_279_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_1.prefab_name].transform, "story_v_out_317161", "317161067", "story_v_out_317161.awb")

						arg_276_1:RecordAudio("317161067", var_279_6)
						arg_276_1:RecordAudio("317161067", var_279_6)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_317161", "317161067", "story_v_out_317161.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_317161", "317161067", "story_v_out_317161.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_7 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_7 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_7

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_7 and arg_276_1.time_ < 0 + var_279_7 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play317161068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 317161068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play317161069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.85

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_1 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(317161068).content)

				arg_280_1.text_.text = var_283_1

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_3 = 34 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 34)

				if (34 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 34)) > 0 and var_283_0 < var_283_3 then
					arg_280_1.talkMaxDuration = var_283_3

					if var_283_3 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_3 + 0
					end
				end

				arg_280_1.text_.text = var_283_1
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_4 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_4

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play317161069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 317161069
		arg_284_1.duration_ = 9.2

		local var_284_0 = {
			zh = 9.2,
			ja = 8.466
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
			arg_284_1.auto_ = false
		end

		function arg_284_1.playNext_(arg_286_0)
			arg_284_1.onStoryFinished_()
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.6

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[81].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10003")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_1 = arg_284_1:GetWordFromCfg(317161069)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 24 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 24)

				if (24 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 24)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317161", "317161069", "story_v_out_317161.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_317161", "317161069", "story_v_out_317161.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_317161", "317161069", "story_v_out_317161.awb")

						arg_284_1:RecordAudio("317161069", var_287_6)
						arg_284_1:RecordAudio("317161069", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_317161", "317161069", "story_v_out_317161.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_317161", "317161069", "story_v_out_317161.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/K11f",
		"TextureConfig/Background/S0609"
	},
	voices = {
		"story_v_out_317161.awb"
	}
}
